//
//  File.swift
//  
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

struct FileSystemManager {
    static func audioFileURL(for bank: Bank) -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileURL = documentsPath.appendingPathComponent("\(bank.getFileName()).wav")
        return audioFileURL
    }
    
    static func duplicateAndRenameFile(originalFileURL: URL, newFileName: String) {
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let newFilePath = documentsDirectory.appendingPathComponent(newFileName)
        
        do {
            // Check if the file already exists
            if fileManager.fileExists(atPath: newFilePath.path) {
                try fileManager.removeItem(at: newFilePath)
                try fileManager.copyItem(at: originalFileURL, to: newFilePath)
                print("File replaced successfully.")
            } else {
                try fileManager.copyItem(at: originalFileURL, to: newFilePath)
                print("File duplicated successfully.")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    static func loadDefaultSamples() {
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let mapping: [Bank: String] = [
            .bank1: "DefaultSample-Kick",
            .bank2: "DefaultSample-Snare",
            .bank3: "DefaultSample-Clap",
            .bank4: "DefaultSampleLong-Beat1",
            .bank5: "DefaultSampleLong-Beat2",
            .bank6: "DefaultSampleLong-Synths",
            .bank7: "DefaultSample-Vocal",
        ]
        
        for (bank, fileName) in mapping {
            let bundleURL = Bundle.main.url(forResource: fileName, withExtension: "wav")
            let destinationURL = documentsDirectory.appendingPathComponent("\(bank.getFileName()).wav")
            
            do {
                // Check if the file already exists
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                    try fileManager.copyItem(at: bundleURL!, to: destinationURL)
                    print("File replaced successfully.")
                } else {
                    try fileManager.copyItem(at: bundleURL!, to: destinationURL)
                    print("File duplicated successfully.")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
