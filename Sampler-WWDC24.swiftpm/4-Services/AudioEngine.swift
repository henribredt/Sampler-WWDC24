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
    
    func playSound(fileURL: URL, playerIndex: Int, pitch: Float = 0) {
        guard playerIndex < audioPlayers.count else { return }
        
        let audioPlayer = audioPlayers[playerIndex]
        
        // Stop and reset the player before playing a new sound
        audioPlayer.stop()
        audioPlayer.reset()
        
        // Set pitch effect
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        audioEngine.attach(pitchEffect)
        
        audioEngine.connect(audioPlayer, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: audioEngine.mainMixerNode, format: nil)
        
        // Load and schedule the sound file
        do {
            let audioFile = try AVAudioFile(forReading: fileURL)
            audioPlayer.scheduleFile(audioFile, at: nil, completionHandler: nil)
            audioPlayer.play()
        } catch {
            print("Error loading sound file: \(error.localizedDescription)")
        }
    }
    
    func stopAllSounds() {
        for audioPlayer in audioPlayers {
            audioPlayer.stop()
            audioPlayer.reset()
        }
    }
}
