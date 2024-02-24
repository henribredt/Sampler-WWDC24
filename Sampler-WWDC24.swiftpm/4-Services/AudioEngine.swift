//
//  AudioEngine.swift
//  Pocket Sampler
//
//  Created by Henri Bredt on 22.02.24.
//

import AVFoundation

class AudioEngine: ObservableObject {
    var audioEngine: AVAudioEngine!
    var audioPlayers: [AVAudioPlayerNode] = []
    var mixer: AVAudioMixerNode!
    var playerTimerDictionary: [AVAudioPlayerNode: Timer] = [:]
    
    @Published var playingBanks: Set<Bank> = Set<Bank>()
   
    init() {
        audioEngine = AVAudioEngine()
        configureAudioEngine()
    }
    
    func configureAudioEngine() {
        // Create 10 players: 9 for Sample playing and 1 (the last) for system sounds
        for _ in 0..<10 {
            // Connect nodes in the audio engine
            let audioPlayer = AVAudioPlayerNode()
            audioEngine.attach(audioPlayer)
            audioPlayers.append(audioPlayer)
        }
        
        mixer = audioEngine.mainMixerNode
        
        for audioPlayer in audioPlayers {
            audioEngine.connect(audioPlayer, to: mixer, format: nil)
        }
        
        // Connect the mixer to the audio engine's output node
        audioEngine.connect(mixer, to: audioEngine.outputNode, format: nil)
        
        // Start the audio engine
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }
    
    /// - returns: Duration of the playing systemSound
    @discardableResult
    func playSystemSound(_ systemSound: SystemSound) -> Double {
        var soundLength: Double = 0.0
        
        guard 9 < audioPlayers.count else { return soundLength }
        
        let audioPlayer = audioPlayers[9] // the last player is reserved for system sounds
        
        audioPlayer.stop()
        audioPlayer.reset()
        
        audioPlayer.volume = 0.3
        
        audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: nil)
        
        do {
            let audioFile = try AVAudioFile(forReading: systemSound.getURL())
            audioPlayer.scheduleFile(audioFile, at: nil)
            
            soundLength = Double(audioFile.length) / audioFile.processingFormat.sampleRate
            
            // For whatever reason, this is required for running it in Swift Playgrounds.
            // Works fine without it when running from Xcode
            if !audioEngine.isRunning {
                try? audioEngine.start()
            }
            
            audioPlayer.play()
        } catch {
            print("Error loading system sound file: \(error.localizedDescription)")
        }
        
        return soundLength
    }
    
    func playSound(fileURL: URL, playerIndex: Int, pitch: Float = Effect.pitch.defaultValue(), lowPassFrequency: Float = Effect.lowpass.defaultValue(), gain: Float = Effect.gain.defaultValue(), startTime: Double = Double(Effect.trimFromStart.defaultValue())) {
        
        guard playerIndex < audioPlayers.count else { return }
        
        let audioPlayer = audioPlayers[playerIndex]
        
        // Stop and reset the player before playing a new sound
        audioPlayer.stop()
        audioPlayer.reset()
        
        // Set gain
        audioPlayer.volume = gain
        
        // Set pitch effect
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        audioEngine.attach(pitchEffect)
        
        // Set lowpass effect
        let lowPassFilter = AVAudioUnitEQ(numberOfBands: 1)
        lowPassFilter.bands[0].filterType = .lowPass
        lowPassFilter.bands[0].frequency = lowPassFrequency // Adjust the cutoff frequency as needed in Range 0...22,000.0
        lowPassFilter.bands[0].bypass = false
        audioEngine.attach(lowPassFilter)
        
        audioEngine.connect(audioPlayer, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: lowPassFilter, format: nil)
        audioEngine.connect(lowPassFilter, to: audioEngine.mainMixerNode, format: nil)
    
        
        // Load, trim and schedule the sound file
            do {
                let audioFile = try AVAudioFile(forReading: fileURL)
                
                // Read the entire audio file into a buffer
                let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
                try audioFile.read(into: audioFileBuffer!)
                
                // Calculate the starting frame based on startTime
                let startingFrame = AVAudioFramePosition(startTime * audioFile.processingFormat.sampleRate)
                
                // Calculate the frame count for the remaining audio from the starting frame
                let remainingFrameCount = AVAudioFrameCount(audioFileBuffer!.frameLength) - AVAudioFrameCount(startingFrame)
                
                // Create a new buffer to hold the trimmed audio data
                let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: remainingFrameCount)
                
                // Copy the trimmed portion from the original buffer to the new buffer
                buffer?.frameLength = remainingFrameCount
                
                for channel in 0..<Int(audioFile.processingFormat.channelCount) {
                    let destination = buffer!.floatChannelData![channel]
                    let source = audioFileBuffer!.floatChannelData![channel] + Int(startingFrame)
                    memcpy(destination, source, Int(remainingFrameCount) * MemoryLayout<Float>.size)
                }
                
                // Schedule the buffer for playback
                audioPlayer.scheduleBuffer(buffer!, at: nil, options: .interrupts, completionHandler: nil)
                
                // Get the audio duration
               // let duration = Double(audioFile.length) / audioFile.processingFormat.sampleRate
                
                let duration = Double(buffer!.frameLength) / audioFile.processingFormat.sampleRate

                // Invalidate any existing timer for this player
                invalidateTimer(forPlayer: audioPlayer)

                // Start a timer to fire once when the duration is over
                let playbackTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] timer in
                    // Audio has finished playing, update playingBanks on the main thread
                    DispatchQueue.main.async {
                        if let bank = Bank.from(playerIndex: playerIndex) {
                            self?.removeFromPlayingBanks(bank)
                        }
                        
                        // Invalidate the timer after completing playback-related tasks
                        self?.invalidateTimer(forPlayer: audioPlayer)
                    }
                }

                // Store the player and its timer in the dictionary
                playerTimerDictionary[audioPlayer] = playbackTimer

                // For whatever reason, this is required for running it in Swift Playgrounds.
                // Works fine without it when running from Xcode
                if !audioEngine.isRunning {
                    try? audioEngine.start()
                }
                
                audioPlayer.play()

                if let bank = Bank.from(playerIndex: playerIndex) {
                    addToPlayingBanks(bank)
                }
        } catch {
            print("Error loading sound file: \(error.localizedDescription)")
            playSystemSound(.invalidAction)
        }
        
        #if DEBUG
        print("Active sample playerTimers \(playerTimerDictionary.count)/9")
        if playerTimerDictionary.count > 9 {
            fatalError("More playerTimers than allowed are running. Looks like timers are not properly invalidated.")
        }
        #endif
    }
    
    func stopAllSounds() {
        for audioPlayer in audioPlayers {
            audioPlayer.stop()
            audioPlayer.reset()
        }
        resetPlayingBanks()
        
        for (_, timer) in playerTimerDictionary {
            timer.invalidate()
        }
        playerTimerDictionary.removeAll()
    }
    
    // Helper method to invalidate the timer for a specific player
    func invalidateTimer(forPlayer player: AVAudioPlayerNode) {
        if let existingTimer = playerTimerDictionary.removeValue(forKey: player) {
            existingTimer.invalidate()
        }
    }
}

extension AudioEngine {
    // Manipulate state
    
    func addToPlayingBanks(_ bank: Bank) {
        playingBanks.insert(bank)
    }
    
    func removeFromPlayingBanks(_ bank: Bank) {
        playingBanks.remove(bank)
    }
    
    func resetPlayingBanks() {
        playingBanks.removeAll()
    }
}
