//
//  WeatherInfoEntity.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

class WeatherInfoEntity: NSObject, Codable {

    let latitude: Double?
    let longitude: Double?
    let timezone: String?
    let current: CurrentWeatherEntity?
    let hourly: HourlyWeatherEntity?
    let weekly: WeeklyWeatherEntity?

    private enum CodingKeys: String, CodingKey {
        case timezone, latitude, longitude
        case current = "currently"
        case hourly = "hourly"
        case weekly = "daily"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        current = try values.decodeIfPresent(CurrentWeatherEntity.self, forKey: .current)
        hourly = try values.decodeIfPresent(HourlyWeatherEntity.self, forKey: .hourly)
        weekly = try values.decodeIfPresent(WeeklyWeatherEntity.self, forKey: .weekly)
    }
}
