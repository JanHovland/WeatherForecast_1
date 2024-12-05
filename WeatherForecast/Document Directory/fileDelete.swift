//
//  fileDelete.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2024.
//

import SwiftUI

func fileDelete(_ fileName: String) {

    let fileManager = FileManager.default
    // Get the URL for the Documents directory
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            // Check if the file exists
            if fileManager.fileExists(atPath: fileURL.path) {
                // Delete the file
                try fileManager.removeItem(at: fileURL)
                print("File deleted successfully")
            } else {
                print("File does not exist")
            }
        } catch {
            print("Error deleting file: \(error.localizedDescription)")
        }
    }
}
