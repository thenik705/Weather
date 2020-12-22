//
//  HourlyWeatherItemCell.swift
//  Weather
//
//  Created by Nik on 21.12.2020.
//

import UIKit
import CoreDataKit

class HourlyWeatherItemCell: UICollectionViewCell {

    static let identifier = "HourlyWeatherItemCell"

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    
    func loadCell(_ hourly: Hourlies) {
        var date = Date()

        if let hourlyDate = hourly.date {
            date = DateUtils.getTimeString(hourlyDate)
        }

        weatherImage.image = ImageEntity.byImageId(hourly.getImageId())?.getImage()
        let nowHour = Calendar.current.component(.hour, from: Date())
        let nowNewDate = DateUtils.setTimeToDate(Date(), hour: nowHour, minute: 0, seconds: 0)
        let isNowTime = DateUtils.localeShortTime(nowNewDate) == DateUtils.localeShortTime(date)

        weatherDate.text = DateUtils.localeShortTime(date)
        weatherTemperature.text = isNowTime ? "now" : String(format: "%.1f", Double(truncating: hourly.temperature)) + "°"
        
        layer.borderWidth = isNowTime ? 0 : 0.5
        layer.borderColor = isNowTime ? .none : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        weatherImage.tintColor = isNowTime ? .white : .systemBlue
        weatherTemperature.textColor = isNowTime ? .systemBlue : .black
        weatherDate.textColor = weatherTemperature.textColor
        
        backgroundColor = isNowTime ? #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9803921569, alpha: 1) : .clear
    }
}
