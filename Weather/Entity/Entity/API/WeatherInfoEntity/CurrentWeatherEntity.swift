//
//  CurrentWeatherEntity.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

class CurrentWeatherEntity: NSObject, Codable {

    let timeStamp: Int?
    let summary: String?
    let imageId: String?
    let temperature: Double?
    let apparentTemperature: Double?
    let uvIndex: Int?
    let pressure: Double?
    
    private enum CodingKeys: String, CodingKey {
        case summary, temperature, apparentTemperature, uvIndex, pressure
        case imageId = "icon"
        case timeStamp = "time"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        timeStamp = try values.decodeIfPresent(Int.self, forKey: .timeStamp)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        imageId = try values.decodeIfPresent(String.self, forKey: .imageId)
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
        apparentTemperature = try values.decodeIfPresent(Double.self, forKey: .apparentTemperature)
        uvIndex = try values.decodeIfPresent(Int.self, forKey: .uvIndex)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
    }
}

