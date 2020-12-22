//
//  API.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

//https://api.darksky.net
//APIKEY: d7195ca6bf988f63b58b61b868560120
//forecast/APIKEY/LATITUDE,LONGITUDE
//forecast/APIKEY/LATITUDE,LONGITUDE,TIMESTAMP

class API {
    private static let BASE_URL = "https://api.darksky.net"
    private static let BASE_API_KEY = "d7195ca6bf988f63b58b61b868560120"
    
    private static let REST_FORECAST_LOCATION_TIME = "/forecast/%@/%@,%@,%@?units=si"
    private static let REST_FORECAST_LOCATION_WEEKLY = "/forecast/%@/%@,%@?units=si"
    
    func getWeatherLocationInfo(_ callback: NSObject, latitude: String, longitude: String) {
        let nowStartDate = Int(DateUtils.clearTime(Date()).timeIntervalSince1970)
        getRequest(callback, url: String(format: API.REST_FORECAST_LOCATION_TIME, API.BASE_API_KEY, latitude, longitude, "\(nowStartDate)"), parser: WeatherParser())
    }
    
    func getWeeklyLocationInfo(_ callback: NSObject, latitude: String, longitude: String) {
        getRequest(callback, url: String(format: API.REST_FORECAST_LOCATION_WEEKLY, API.BASE_API_KEY, latitude, longitude), parser: WeeklyParser())
    }
    
    private func getRequest(_ callback: NSObject, url: String, parser: IParser) {
        performRequest(callback, url: url, parser: parser)
    }
    
    private func performRequest(_ callback: NSObject, url: String, method: String = "GET", parser: IParser) {
        if let url = URL(string: API.BASE_URL + url) {
            var request = URLRequest(url: url)
            request.httpMethod = method
            print(request)
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                if let data = data, let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    switch statusCode {
                    case 200..<300:
                        let result = parser.parse(data)
                        callback.performSelector(onMainThread: #selector(APICallback.onLoaded(_:)), with: result, waitUntilDone: false)
                    default:
                        var error: NSObject?
                        if let errorItem = ErrorParser().parse(data) as? ErrorEntity {
                            errorItem.setCode(statusCode)
                            error = errorItem
                        }
                        
                        callback.performSelector(onMainThread: #selector(APICallback.onError), with: error, waitUntilDone: false)
                    }
                }
            }).resume()
        } else {
            print("ERROR URL!")
        }
    }
    
    private func getData(_ data: Data?) -> Any? {
        do {
            if let data = data {
                if let ipString = NSString(data: data, encoding: String.Encoding.utf8.rawValue), let jsonData = ipString.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true) {
                    let data = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                    return data
                }
            }
        } catch {
            print("error getData")
        }
        return nil
    }
}
