//
//  getDocumentDirectory.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2024.
//

import Foundation

func getDocumentsDirectory() -> URL {
    ///
    /// Get the URL to the app's Documents directory
    ///
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
