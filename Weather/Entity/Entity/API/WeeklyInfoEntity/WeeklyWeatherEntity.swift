//
//  WeeklyWeatherEntity.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

class WeeklyWeatherEntity: NSObject, Codable {

    let data: [WeeklyWeatherItemEntity]?

    private enum CodingKeys: String, CodingKey {
        case data
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        data = try values.decodeIfPresent([WeeklyWeatherItemEntity].self, forKey: .data)
    }
}
