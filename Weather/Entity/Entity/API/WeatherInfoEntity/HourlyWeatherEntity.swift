//
//  HourlyWeatherEntity.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

class HourlyWeatherEntity: NSObject, Codable {

    let data: [CurrentWeatherEntity]?
    let summary: String?
    let iconName: String?

    private enum CodingKeys: String, CodingKey {
        case data, summary
        case iconName = "icon"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        data = try values.decodeIfPresent([CurrentWeatherEntity].self, forKey: .data)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        iconName = try values.decodeIfPresent(String.self, forKey: .iconName)
    }
}


