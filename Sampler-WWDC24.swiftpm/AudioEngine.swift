//
//  AudioEngine.swift
//  Pocket Sampler
//
//  Created by Henri Bredt on 22.02.24.
//

import Foundation
import AVFoundation

struct AudioEngine {
    static var player: AVAudioPlayer?
    
    private static func playSound(resource: String, type: String) {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
            print("cant find file")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player!.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func playSound() {
        player?.stop()
        playSound(resource: "drum", type: "mp3")
    }
}
