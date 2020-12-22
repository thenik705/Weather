//
//  HistoryCell.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
import CoreDataKit

class HourlyCell: UITableViewCell {

    static let identifier = "HourlyCell"

    @IBOutlet weak var hourlyWeatherCollectionView: HourlyWeatherCollectionView!

    func loadCell(_ hourlies: [Hourlies]) {
        hourlyWeatherCollectionView.setHourliesWeather(hourlies)

        contentView.layoutIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

