//
//  deleteJSONFile.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/11/2024.
//

import SwiftUI

func deleteJSONFile(named fileName: String) -> LocalizedStringKey {
    var errorMessage: LocalizedStringKey = ""
    let fileManager = FileManager.default
    do {
        // Get the URL for the Documents directory
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            // Check if file exists before deleting
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
                errorMessage = ""
            } else {
                errorMessage = "File does not exist."
            }
        }
    } catch {
        errorMessage = "\(error.localizedDescription)"
    }
    return (errorMessage)
}

func fileJSONExist(named fileName: String) -> (LocalizedStringKey, Bool) {
    var errorMessage: LocalizedStringKey = ""
    var exist = false
    
    let fileManager = FileManager.default
    
    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // Check if file exists before deleting
        if fileManager.fileExists(atPath: fileURL.path) {
            exist = true
        } else {
            errorMessage = "File does not exist."
        }
    }
    
    return (errorMessage, exist)
}



