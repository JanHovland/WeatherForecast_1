//
//  loadJSONData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 22/11/2024.
//

import SwiftUI

func loadJSONData(_ fileName: String) -> (LocalizedStringKey, String?) {
    var errorMessage: LocalizedStringKey = ""
    
    let documentsURL = getDocumentsDirectory()
    let fileURL = documentsURL.appendingPathComponent(fileName)
    do {
        let decodedData = try String(contentsOf: fileURL, encoding: .utf8)
        return (errorMessage, decodedData)
    } catch {
        errorMessage = "\(error.localizedDescription)"
        return (errorMessage, nil)
    }
}

