//
//  saveJSONData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 22/11/2024.
//

import SwiftUI

func saveJSONData(_ fileName: String,
                  _ data: String) -> LocalizedStringKey {
    
    var errorMessage: LocalizedStringKey = ""
    ///
    /// Convert model to JSON data
    ///
    do {
        let jsonData = try JSONEncoder().encode(data)
        ///
        /// Get the URL for the document directory
        ///
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            ///
            /// Write JSON data to file
            ///
            try jsonData.write(to: fileURL)
        }
    } catch {
        errorMessage = "\(error.localizedDescription)"
    }
    
    return errorMessage
}

