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
}
