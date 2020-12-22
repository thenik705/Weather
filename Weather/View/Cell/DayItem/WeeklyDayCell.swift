//
//  WeeklyDayCell.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import UIKit
import CoreDataKit

class WeeklyDayCell: UITableViewCell {

    static let identifier = "WeeklyDayCell"

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!

    func loadCell(_ weeklyDay: WeeklyDay) {
        weatherImage.image = ImageEntity.byImageId(weeklyDay.getImageId())?.getImage()
        if let date = weeklyDay.date {
            weatherDate.text = DateUtils.getTimeCalendar(DateUtils.getTimeString(date))
        }
        
        let temperatureLow = String(format: "%.1f", Double(weeklyDay.temperatureLow)) + "°"
        let temperatureHigh = String(format: "%.1f", Double(weeklyDay.temperatureHigh)) + "°"
        
        weatherTemperature.text = "\(temperatureHigh) / \(temperatureLow)"
    }
}



