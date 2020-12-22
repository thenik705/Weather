//
//  WeeklyWeatherItemEntity.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import Foundation

class WeeklyWeatherItemEntity: NSObject, Codable {

    let timeStamp: Int?
    let iconName: String?
    let temperatureHigh: Double?
    let temperatureLow: Double?
    
    private enum CodingKeys: String, CodingKey {
        case temperatureHigh, temperatureLow
        case iconName = "icon"
        case timeStamp = "time"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        timeStamp = try values.decodeIfPresent(Int.self, forKey: .timeStamp)
        iconName = try values.decodeIfPresent(String.self, forKey: .iconName)
        temperatureHigh = try values.decodeIfPresent(Double.self, forKey: .temperatureHigh)
        temperatureLow = try values.decodeIfPresent(Double.self, forKey: .temperatureLow)
    }
}


