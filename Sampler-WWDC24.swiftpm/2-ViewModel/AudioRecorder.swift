//
//  AudioRecorder.swift
//  Pocket Sampler
//
//  Created by Henri Bredt on 22.02.24.
//

import SwiftUI
import AVFoundation

class AudioRecorder : NSObject, ObservableObject {
    var playerBankDictionary: [AVAudioPlayer: Bank] = [:]
    
    @Published var isRecording : Bool = false
    
    var pitch: Float = 1.0
    
    @Published var audioRecorder: AVAudioRecorder!
    @Published var audioPlayers: [AVAudioPlayer] = []
    
    @Published var playingBanks: [Bank] = []
    
    
    func startRecording(fileName: String) {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true)
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioURL = documentsPath.appendingPathComponent("\(fileName).wav")
            
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatLinearPCM,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                AVEncoderBitRateKey: 320000,
                AVNumberOfChannelsKey: 2,
                AVSampleRateKey: 44100.0
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder.record()
            
        } catch {
            print("Error setting up recording session: \(error.localizedDescription)")
        }
    }
    
    func playRecoding(bank: Bank){
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let playAudioURL = documentsPath.appendingPathComponent("\(bank.getFileName()).wav")
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: playAudioURL)
            audioPlayer.delegate = self // Set the delegate to receive playback completion events
            audioPlayer.enableRate = true
            
            let config = BankPlayerConfig.load(for: bank)
            
            audioPlayer.rate = config?.pitch ?? 1.0
            audioPlayer.play()
            
            // Associate the audioPlayer with the bank using a dictionary
            playerBankDictionary[audioPlayer] = bank
            
            audioPlayers.append(audioPlayer)
            playingBanks.append(bank)
            print("Audio players: \(audioPlayers.count)")
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
        
    }
    
    func stopAll() {
        for player in audioPlayers {
            player.stop()
        }
    }
    
    func increasePitch(bank: Bank) {
        if pitch < 3 {
            stopAll()
            pitch += 0.2
            BankPlayerConfig.save(BankPlayerConfig(pitch: pitch), for: bank)
            playRecoding(bank: bank)
        }
    }

    func decreasePitch(bank: Bank) {
        if pitch > -0.8 {
            stopAll()
            pitch -= 0.2
            BankPlayerConfig.save(BankPlayerConfig(pitch: pitch), for: bank)
            playRecoding(bank: bank)
        }
    }

    
    
    func playx(bank: Bank, pitchy: Float) {
        let audioEngine = AVAudioEngine()
            let audioPlayerNode = AVAudioPlayerNode()
          //  let pitchEffect = AVAudioUnitTimePitch()
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsPath.appendingPathComponent("\(bank.getFileName()).wav")
        let audioFile = try! AVAudioFile(forReading: fileURL)
        
            audioEngine.attach(audioPlayerNode)
       //     audioEngine.attach(pitchEffect)
            
        //
       // audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        
        // Start the audio engine
        do {
           
    
            // Load an audio file
            
            
         //   pitchEffect.pitch = pitch * 1200
            
            // Schedule the audio file for playback
            audioPlayerNode.scheduleFile(audioFile, at: nil)
            
            // Start the audio player node
            try audioEngine.start()
            audioPlayerNode.play()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension AudioRecorder: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let bank = playerBankDictionary[player] {
            if let index = audioPlayers.firstIndex(of: player) {
                audioPlayers.remove(at: index)
                
                // Turn LED off after playing
                if let index = playingBanks.firstIndex(of: bank) {
                    playingBanks.remove(at: index)
                }
            }
        }
    }
}


