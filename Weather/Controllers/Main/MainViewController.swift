//
//  MainViewController.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
import CoreDataKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: MainTableView!
    
    var weather: Weather?

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        initSettings()
    }

    // MARK: - Settings
    func initSettings() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.isNavigationBarHidden = true

        self.loadLogicEntity()
    }

    // MARK: - Objc functions

    // MARK: - Additional functions
    func loadLogicEntity(_ newWeather: WeatherInfoEntity? = nil) {
        if let currentWeather = newWeather?.current {
            let convertDate = DateUtils.convertDateIntToString(currentWeather.timeStamp ?? 0)

            if let weatherBD = CoreDataManager.loadFromDbByItem(clazz: Weather.self, itemField: "date", itemParametr: convertDate) {
                weather = weatherBD
            } else {
                weather = Weather()
            }

            weather?.latitude = (newWeather?.latitude! ?? 0) as NSNumber
            weather?.longitude = (newWeather?.longitude! ?? 0) as NSNumber
            weather?.timeZone = newWeather?.timezone ?? ""
            weather?.date = convertDate
            weather?.imageId = currentWeather.imageId
            weather?.summary = currentWeather.summary
            weather?.temperature = currentWeather.temperature! as NSNumber
            weather?.apparentTemperature = currentWeather.apparentTemperature! as NSNumber
            weather?.uvIndex = currentWeather.uvIndex! as NSNumber
            weather?.pressure = currentWeather.pressure! as NSNumber
            
            CoreDataManager.instance.saveContext()
        } else {
            weather = CoreDataManager.loadFirstFromDb(clazz: Weather.self, keyForSort: Const.SORT_DATE_TIME)
        }

        if let hourliesWeather = newWeather?.hourly, let weather = weather {
            hourliesWeather.data?.forEach({ (weatherHourItem) in
                let convertDate = DateUtils.convertDateIntToString(weatherHourItem.timeStamp ?? 0, isClearAll: false)
                var hourItem: Hourlies?

                if let hourBD = CoreDataManager.loadFromDbByItem(clazz: Hourlies.self, itemField: "date", itemParametr: convertDate) {
                    hourItem = hourBD
                } else {
                    hourItem = Hourlies()
                }

                hourItem?.weatherId = weather.getId() as! NSNumber
                hourItem?.date = convertDate
                hourItem?.imageId = weatherHourItem.imageId
                hourItem?.temperature = weatherHourItem.temperature! as NSNumber
                
                CoreDataManager.instance.saveContext()
            })
        }

        mainTableView.setInfo(weather, rootController: self)
        UIView.animate(withDuration: 0.3) {
            self.mainTableView.alpha = 1
        }
    }
    
    func errorLogic(_ errorEntity: ErrorEntity? = nil) {
        let alert = UIAlertController(title: "Error", message: errorEntity?.getErrorTitle(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: HeaderCellDelegate {
    func loadWeatcherLocaton(_ latitude: String, _ longitude: String) {
        API().getWeatherLocationInfo(APICallback(completion: { (result: (NSObject)) in
            self.loadLogicEntity(result as? WeatherInfoEntity)
        }, error: { (resultError: (ErrorEntity)) in
            self.errorLogic(resultError)
        }), latitude: latitude, longitude: longitude)
    }
    
    func showErrorDialog() {
        errorLogic()
    }
}

extension MainViewController: DaysListDelegate {
    func tapDaysAction() {
        let controller = Const.GET_STORYBOARD.instantiateViewController(withIdentifier: Const.DAYS_LIST_VIEW_CONTROLLER) as! DaysViewController

        controller.setInfo(weather, rootController: self)
        let nController = UINavigationController(rootViewController: controller)
        self.present(nController, animated: true, completion: nil)
    }
}
