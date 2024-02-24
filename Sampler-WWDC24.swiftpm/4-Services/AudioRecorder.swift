//
//  AudioRecorder.swift
//  Pocket Sampler
//
//  Created by Henri Bredt on 22.02.24.
//

import SwiftUI
import AVFoundation

class AudioRecorder : NSObject, ObservableObject {
    @Published var isRecording : Bool = false
    @Published var isPreRrecoring: Bool = false // lets the display element flash before recoring
    @Published var audioRecorder: AVAudioRecorder!

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
            
            isRecording = true
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder.record()
        } catch {
            print("Error setting up recording session: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
            isRecording = false
        }
    }
}
