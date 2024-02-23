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
        // Connect nodes in the audio engine
        for _ in 0..<9 {
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
    
    func playSound(fileURL: URL, playerIndex: Int, pitch: Float = Effect.pitch.defaultValue(), lowPassFrequency: Float = Effect.lowpass.defaultValue(), gain: Float = Effect.gain.defaultValue()) {
        
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
        
        // Load and schedule the sound file
            do {
                let audioFile = try AVAudioFile(forReading: fileURL)
                audioPlayer.scheduleFile(audioFile, at: nil)

                // Get the audio duration
                let duration = Double(audioFile.length) / audioFile.processingFormat.sampleRate

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

                audioPlayer.play()

                if let bank = Bank.from(playerIndex: playerIndex) {
                    addToPlayingBanks(bank)
                }
        } catch {
            print("Error loading sound file: \(error.localizedDescription)")
        }
        
        #if DEBUG
        print("Active playerTimers \(playerTimerDictionary.count)/9")
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
