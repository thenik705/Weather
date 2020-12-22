//
//  WeatherInfoCell.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
import CoreDataKit

class WeatherInfoCell: UITableViewCell {

    static let identifier = "WeatherInfoCell"

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!

    func loadCell(_ weather: Weather) {
        weatherImage.image = ImageEntity.byImageId(weather.getImageId())?.getImage()
        if let date = weather.date {
            weatherDate.text = DateUtils.getTimeCalendar(DateUtils.getTimeString(date))
        }
        
        weatherStatus.text = weather.summary
        weatherTemperature.text = String(format: "%.1f", Double(weather.temperature)) + "°"

    }
}


