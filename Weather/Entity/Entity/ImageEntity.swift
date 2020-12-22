//
//  ImageEntity.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import UIKit

class ImageEntity {

    static public let clearDay = ImageEntity("clear-day", systemImage: "sun.max.fill")
    static public let clearNight = ImageEntity("clear-night", systemImage: "moon.stars.fill")
    static public let cloudy = ImageEntity("cloudy", systemImage: "cloud.fill")
    static public let fog = ImageEntity("fog", systemImage: "cloud.fog.fill")
    static public let partlyCloudyDay = ImageEntity("partly-cloudy-day", systemImage: "cloud.sun.fill")
    static public let partlyCloudNight = ImageEntity("partly-cloudy-night", systemImage: "cloud.moon.fill")
    static public let rain = ImageEntity("rain", systemImage: "cloud.drizzle.fill")
    static public let sleet = ImageEntity("sleet", systemImage: "cloud.hail.fill")
    static public let snow = ImageEntity("snow", systemImage: "cloud.snow.fill")
    static public let wind = ImageEntity("wind", systemImage: "wind")

    
    static public func values() -> [ImageEntity] {
        return [clearDay, clearNight, cloudy, fog, partlyCloudyDay, partlyCloudNight, rain, sleet, snow, wind]
    }

    static public func byImageId(_ imageId: String) -> ImageEntity? {
        return values().filter({ $0.imageId == imageId }).first
    }

    private var imageId: String
    private var systemImage: String

    fileprivate init(_ imageId: String, systemImage: String) {
        self.imageId = imageId
        self.systemImage = systemImage
    }
    
    func getImage() -> UIImage? {
        return UIImage(systemName: systemImage)
    }
}

