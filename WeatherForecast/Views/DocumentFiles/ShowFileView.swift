//
//  ShowFileView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/11/2024.
//

import SwiftUI

struct ShowFileView: View {
    
    @State private var fileNames: [String] = []
    
    var body: some View {
        Text("Files in Document Directory")
        List {
            ForEach (fileNames, id: \.self) { fileName in
                Text(fileName)
            }
            .onDelete(perform: findFileToDelete)
        }
        .onAppear {
            var value: (LocalizedStringKey, [String])
            
            value = loadFiles()
            
            if value.0 == "" {
                fileNames = value.1
            }
        }
    }
    
    func findFileToDelete(at indexSet: IndexSet) {
        for index in indexSet {
            let fileName = fileNames[index]
            _ = deleteJSONFile(named: fileName)
         }
    }
}

