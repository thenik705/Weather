//
//  HeaderCell.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
import CoreDataKit
import CoreLocation

protocol HeaderCellDelegate: class {
    func loadWeatcherLocaton(_ latitude: String, _ longitude: String)
    func showErrorDialog()
}

class HeaderCell: UITableViewCell {

    static let identifier = "HeaderCell"

    weak var delegate: HeaderCellDelegate?
    
    @IBOutlet weak var titleCountry: UILabel!
    @IBOutlet weak var titleCity: UILabel!

    @IBOutlet weak var userImage: UIImageView!

    let locationManager = CLLocationManager()
    
    func loadCell(_ weather: Weather) {
        let (country, city) = weather.getTimeZoneTitle()
    
        titleCountry.text = country
        titleCity.text = city
    }

    @IBAction func getLocationAction(_ sender: Any) {
        if !NetworkHelper.isConnected() {
            delegate?.showErrorDialog()
        } else {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
        }
    }
}

extension HeaderCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            delegate?.loadWeatcherLocaton("\(latitude)","\(longitude)")
            locationManager.stopUpdatingLocation()
        }
    }
}
