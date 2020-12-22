//
//  WeeklyInfoEntity.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import Foundation

class WeeklyInfoEntity: NSObject, Codable {

    let weekly: WeeklyWeatherEntity?

    private enum CodingKeys: String, CodingKey {
        case weekly = "daily"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        weekly = try values.decodeIfPresent(WeeklyWeatherEntity.self, forKey: .weekly)
    }
}

