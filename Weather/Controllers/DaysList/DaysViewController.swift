//
//  DaysViewController.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import UIKit
import CoreDataKit

class DaysViewController: UIViewController {

    @IBOutlet weak var daysTableView: DaysTableView!

    private var rootController: MainViewController?

    private var weather: Weather?
    private var sectionType: SectionType = .list

    override func viewDidLoad() {
        super.viewDidLoad()
        initSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: - Settings
    func initSettings() {
        let buttonClose = Utils.systemButton("multiply")
        buttonClose.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonClose)
 
        self.loadWeeklyEntity()
    }

    // MARK: - Additional functions
    func loadWeeklyLocaton(_ latitude: String, _ longitude: String) {
        API().getWeeklyLocationInfo(APICallback(completion: { (result: (NSObject)) in
            self.loadWeeklyEntity(result as? WeeklyInfoEntity)
        }, error: { (resultError: (ErrorEntity)) in
            self.errorLogic(resultError)
        }), latitude: latitude, longitude: longitude)
    }
    
    func loadWeeklyEntity(_ newWeather: WeeklyInfoEntity? = nil) {
        if let weeklyWeathers = newWeather?.weekly?.data {
            if !weeklyWeathers.isEmpty {
                let allWeeklyDays = CoreDataManager.loadFromDb(clazz: WeeklyDay.self, keyForSort: Const.SORT_ID)
                CoreDataManager.removeCollection(allWeeklyDays)
            }
            weeklyWeathers.forEach({ (weeklyWeather) in
                let convertDate = DateUtils.convertDateIntToString(weeklyWeather.timeStamp ?? 0, isClearAll: false)
                var weeklyItem: WeeklyDay?

                if let weeklyBD = CoreDataManager.loadFromDbByItem(clazz: WeeklyDay.self, itemField: "date", itemParametr: convertDate) {
                    weeklyItem = weeklyBD
                } else {
                    weeklyItem = WeeklyDay()
                }

                weeklyItem?.date = convertDate
                weeklyItem?.imageId = weeklyWeather.iconName
                weeklyItem?.temperatureHigh = weeklyWeather.temperatureHigh! as NSNumber
                weeklyItem?.temperatureLow = weeklyWeather.temperatureLow! as NSNumber
                
                CoreDataManager.instance.saveContext()
            })
        }

        daysTableView?.loadInfo(self)
        UIView.animate(withDuration: 0.3) {
            self.daysTableView?.alpha = 1
        }
    }
    
    func setNavigationTitle(_ weather: Weather) {
        let (country, city) = weather.getTimeZoneTitle()
        navigationItem.setTitle(city, country)
    }

    func setInfo(_ weather: Weather?, rootController: MainViewController) {
        self.weather = weather
        self.rootController = rootController
        
        if let weather = weather {
            setNavigationTitle(weather)
            loadWeeklyLocaton("\(weather.latitude)", "\(weather.longitude)")
        }
    }

    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func errorLogic(_ errorEntity: ErrorEntity? = nil) {
        let alert = UIAlertController(title: "Error", message: errorEntity?.getErrorTitle(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
