//
//  Weather.swift
//  CoreDataKit
//
//  Created by Nik on 22.12.2020.
//

import UIKit
import CoreData

public class Weather: DBEntity, ITitle {

    @NSManaged public var latitude: NSNumber
    @NSManaged public var longitude: NSNumber
    @NSManaged public var timeZone: String?
    @NSManaged public var date: String?
    @NSManaged public var imageId: String?
    @NSManaged public var summary: String?
    @NSManaged public var temperature: NSNumber
    @NSManaged public var apparentTemperature: NSNumber
    @NSManaged public var uvIndex: NSNumber
    @NSManaged public var pressure: NSNumber

    public var hourlies = [Hourlies]()
    
    convenience init() {
        self.init(entity: "Weather", shouldGenerateId: true)
    }
    
    public func getSummary() -> String {
        return summary ?? ""
    }
    
    public func getImageId() -> String {
        return imageId ?? ""
    }
    
    public func getId() -> NSObject {
        return id ?? -1
    }
    
    public func getTimeZoneTitle() -> (String, String) {
        if let stringArray = timeZone?.components(separatedBy: "/") {
            if stringArray.count > 1 {
                let country = stringArray[0]
                let city = stringArray[1]
                
                return (country, city)
            }
        }
        
        return ("", "")
    }
    
    public func getNumberId() -> NSNumber {
        return getId() as! NSNumber
    }
    
    public func getAllHourlies(_ keyForSort: [NSSortDescriptor]) -> [Hourlies] {
        return CoreDataManager.loadHourliesFromDb(weatherId: getNumberId(), limit: 0, keyForSort)
    }
}


