//
//  AudioRecorder.swift
//  Pocket Sampler
//
//  Created by Henri Bredt on 22.02.24.
//

import SwiftUI
import AVFoundation

class AudioRecorder : NSObject , ObservableObject , AVAudioPlayerDelegate {
    
    @Published var isRecording : Bool = false
    
    @Published var audioRecorder: AVAudioRecorder!
    @Published var audioPlayer: AVAudioPlayer!
    @Published var audioURL: URL?
    
 
    func startRecording(fileName: String) {
            let audioSession = AVAudioSession.sharedInstance()

            do {
                try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
                try audioSession.setActive(true)

                let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                audioURL = documentsPath.appendingPathComponent("\(fileName).wav")

                let settings: [String: Any] = [
                    AVFormatIDKey: kAudioFormatLinearPCM,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                    AVEncoderBitRateKey: 320000,
                    AVNumberOfChannelsKey: 2,
                    AVSampleRateKey: 44100.0
                ]

                audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
                audioRecorder.record()

            } catch {
                print("Error setting up recording session: \(error.localizedDescription)")
            }
        }
    
    func playRecoding(fileName: String){
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let playAudioURL = documentsPath.appendingPathComponent("\(fileName).wav")
        
       
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: playAudioURL)
                audioPlayer.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        
    }
    
    func play() throws {
        let engine = AVAudioEngine()
        let speedControl = AVAudioUnitVarispeed()
        var pitchControl = AVAudioUnitTimePitch()
        
        pitchControl.pitch += 50
        
        // 1: load the file
        guard let url = audioURL else {
            return
        }
        let file = try AVAudioFile(forReading: url)

        // 2: create the audio player
        let audioPlayer = AVAudioPlayerNode()

        // 3: connect the components to our playback engine
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)

        // 4: arrange the parts so that output from one is input to another
        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)

        // 5: prepare the player to play its file from the beginning
        audioPlayer.scheduleFile(file, at: nil)

        // 6: start the engine and player
        try engine.start()
        audioPlayer.play()
    }
}
