//
//  GetAverageWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 16/03/2024.
//

import Foundation
import SwiftUI

func GetAverageDayWeather(option: EnumType,
                          placeName: String,
                          startDate: String,
                          endDate: String,
                          lat: Double,
                          lon: Double) async -> (LocalizedStringKey,
                                                 AverageDailyDataRecord) {
    
    ///
    /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31
    ///
    ///     Ny normal i klimaforskningen:
    ///     16.12.2020 | Endret 18.1.2021
    ///     Fra 1. januar 2021 blir 1991-2020 den nye perioden vi tar
    ///     utgangspunkt i når vi snakker om hva som er normalt vær.
    ///     Tidligere har vi brukt 1961-1990.
    ///     Hvorfor bytter vi normalperiode?
    ///     I 1935 ble det enighet i Verdens meteorologiorganisasjon (WMO)
    ///     om at en trengte en felles referanse for klima,
    ///     såkalte standard normaler.
    ///     De ble enige om at hver periode skulle vare 30 år.
    ///     På den måten sikret man en lang nok dataperiode, men unngikk påvirkning
    ///     fra kortvarige variasjoner.
    ///     Den første  normalperioden skulle gå fra 1901 - 1930.
    ///     Det ble også enighet om at normalene skulle byttes hvert 30. år.
    ///     I 2014 vedtok WMO sin Klimakommisjon at normalene fortsatt skal dekke 30 år,
    ///     men nå skal byttes hvert 10. år på grunn av klimaendringene.
    ///     Klimaet i dag endrer seg så mye at normalene i slutten av perioden ikke lenger
    ///     reflekterer det vanlige været i et område.
    ///     Når klimaet endrer seg raskt, slik det gjør nå, må vi endre normalene hyppigere
    ///     enn før for at de bedre skal beskrive det aktuelle klimaet.

    ///
    /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
    ///
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    var averageDailyDataRecord = AverageDailyDataRecord(time: [""],
                                                        precipitationSum: [0.00],
                                                        temperature2MMin: [0.00],
                                                        temperature2MMax: [0.00])
    ///
    /// Finner urlPart1 fra Settings()
    ///
    let urlPart1 = UserDefaults.standard.object(forKey: "Url1OpenMeteo") as? String ?? ""
    if urlPart1 == "" {
        let msg = String(localized: "Update setting for OpenMeteo 1.")
        errorMessage = LocalizedStringKey(msg)
    }
    ///
    /// Finner urlPart2 fra Settings()
    ///
    let urlPart2 = UserDefaults.standard.object(forKey: "Url2OpenMeteo") as? String ?? ""
    if urlPart2 == "" {
        let msg = String(localized: "Update the setting for OpenMeteo 2.")
        errorMessage = LocalizedStringKey(msg)
    }
    ///
    /// Feilmelding dersom urlPart1 og / eller urlPart2 ikke har verdi
    ///
    if urlPart1.count > 0, urlPart2.count > 0 {
        let urlString =
        urlPart1 + "\(lat)" + "&longitude=" + "\(lon)" + urlPart2 + "&start_date=" + startDate + "&end_date=" + endDate
        let url = URL(string: urlString)
        ///
        /// Henter gjennomsnittsdata
        ///
        if let url {
            do {
                let urlSession = URLSession.shared
                let (jsonData, response) = try await urlSession.data(from: url)
                ///
                /// Viser jsonData i klartekst
                ///
                let data = String(data: jsonData, encoding: .utf8)
//                print("Data received: \(data!) ")
                
                ///
                /// Lagre json data
                ///
                
                if option == .years {
                    let value: (LocalizedStringKey)
                    let fileName = placeName + " " + "\(lat)" + " " + "\(lon)" + ".json"
                    
                    //                let fn = "\(lat)" + " " + "\(lon)" + ".json"
                    
                    //                deleteFile("qwerty.json")
                    
                    let _ = loadFiles()
                    
                    value = saveJSONData(fileName, data!)
                    
                    print("Status = \(value)")
                    
                    /*
                     Data received: {"latitude":58.594025,"longitude":5.78714,"generationtime_ms":0.0680685043334961,"utc_offset_seconds":3600,"timezone":"Europe/Oslo","timezone_abbreviation":"CET","elevation":51.0,"daily_units":{"time":"iso8601","precipitation_sum":"mm","temperature_2m_min":"°C","temperature_2m_max":"°C"},"daily":{"time":["1991-01-01","1991-01-02","1991-01-03","1991-01-04","1991-01-05","1991-01-06","1991-01-07","1991-01-08","1991-01-09","1991-01-10"],"precipitation_sum":[3.50,40.70,4.80,20.10,19.60,8.10,7.80,8.60,9.60,10.30],"temperature_2m_min":[3.5,4.0,4.1,2.9,3.4,3.0,2.5,2.2,2.1,3.0],"temperature_2m_max":[4.7,6.6,5.3,6.4,6.0,4.9,4.7,3.7,3.9,4.8]}}
                     711 bytes
                     Data saved to: file:///var/mobile/Containers/Data/Application/868278D1-E459-4DCC-8599-22C01BA7CAF3/Documents/qwerty.json
                     Status = LocalizedStringKey(key: "", hasFormatting: false, arguments: [])
                     */
                    
                    ///
                    /// Lese tilbake json data:
                    ///
                    
                    let value1: (LocalizedStringKey, String?)
                    
                    value1 = loadJSONData(fileName)
                    
                    print("Data read from \(fileName) = \(value1.1!)")
                    
                    /*
                     Data received:
                     {"latitude":57.11775,
                     "longitude":-2.0974426,
                     "generationtime_ms":0.07891654968261719,
                     "utc_offset_seconds":0,
                     "timezone":"Europe/London",
                     "timezone_abbreviation":"GMT",
                     "elevation":24.0,
                     "daily_units":
                     {"time":"iso8601","precipitation_sum":"mm","temperature_2m_min":"°C","temperature_2m_max":"°C"},"daily":
                     {"time":["1991-01-01","1991-01-02","1991-01-03","1991-01-04","1991-01-05","1991-01-06","1991-01-07","1991-01-08","1991-01-09","1991-01-10"],"precipitation_sum":[5.80,0.00,0.00,0.00,6.10,0.70,0.50,0.20,0.30,3.40],"temperature_2m_min":[2.1,3.0,2.6,2.3,3.5,3.4,0.9,0.7,0.9,1.8],"temperature_2m_max":[9.3,9.4,4.5,5.9,5.0,6.3,3.4,2.6,3.4,4.8]}}
                     709 bytes
                     Data saved to: file:///var/mobile/Containers/Data/Application/23DC10C3-1054-4104-813A-07FFADF55CEE/Documents/qwerty.json
                     Status = LocalizedStringKey(key: "", hasFormatting: false, arguments: [])
                     
                     Data read =
                     "{\"latitude\":57.11775,\"longitude\":-2.0974426,
                     \"generationtime_ms\":0.07891654968261719,
                     \"utc_offset_seconds\":0,
                     \"timezone\":\"Europe\/London\",
                     \"timezone_abbreviation\":\"GMT\",
                     \"elevation\":24.0,
                     \"daily_units\":{\"time\":\"iso8601\",\"precipitation_sum\":\"mm\",\"temperature_2m_min\":\"°C\",\"temperature_2m_max\":\"°C\"},\"daily\":{\"time\":[\"1991-01-01\",\"1991-01-02\",\"1991-01-03\",\"1991-01-04\",\"1991-01-05\",\"1991-01-06\",\"1991-01-07\",\"1991-01-08\",\"1991-01-09\",\"1991-01-10\"],\"precipitation_sum\":[5.80,0.00,0.00,0.00,6.10,0.70,0.50,0.20,0.30,3.40],\"temperature_2m_min\":[2.1,3.0,2.6,2.3,3.5,3.4,0.9,0.7,0.9,1.8],\"temperature_2m_max\":[9.3,9.4,4.5,5.9,5.0,6.3,3.4,2.6,3.4,4.8]}}"
                     
                     */
                    
                }
                errorMessage = ServerResponse(error:"\(response)")
                ///
                /// Finner statusCode fra response
                ///
                let res = response as? HTTPURLResponse
                httpStatus = res!.statusCode
                ///
                /// Sjekker httpStatus
                ///
                if httpStatus == 200 {
                    if let averageData = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData) {
                        ///
                        /// Oppdatering av averageDailyDataRecord
                        ///
                        averageDailyDataRecord.time = (averageData.daily.time)
                        averageDailyDataRecord.precipitationSum = (averageData.daily.precipitationSum)
                        averageDailyDataRecord.temperature2MMin = (averageData.daily.temperature2MMin)
                        averageDailyDataRecord.temperature2MMax = (averageData.daily.temperature2MMax)
                        errorMessage = ""
                    } else {
                        let msg = String(localized: "Can not find any average data")
                        errorMessage = LocalizedStringKey(msg)
                    }
                } else {
                    errorMessage = ServerResponse(error:"\(response)")
                }
            } catch {
                let response = CatchResponse(response: "\(error)",
                                             searchFrom: "Code=",
                                             searchTo: "UserInfo")
                errorMessage = "\(response)"
            }
        }
    }
    return (errorMessage, averageDailyDataRecord)
}

func deleteFile(_ fileName: String) {
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

func loadFiles() -> (LocalizedStringKey, [String]) {
    
    var fileNames: [String] = []
    var errorMessage: LocalizedStringKey = ""
    
    let fileManager = FileManager.default
    
    do {
        // Get the URL of the document directory
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        // Get all files in the directory
        let files = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
        
        // Extract the file names
        fileNames = files.map { $0.lastPathComponent }
    } catch {
        errorMessage = "\(error.localizedDescription)"
    }
    return (errorMessage, fileNames)
}
