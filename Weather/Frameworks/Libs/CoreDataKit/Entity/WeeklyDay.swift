//
//  Weekly.swift
//  CoreDataKit
//
//  Created by Nik on 22.12.2020.
//

import UIKit
import CoreData

public class WeeklyDay: DBEntity, ITitle {
    
    @NSManaged public var date: String?
    @NSManaged public var imageId: String?
    @NSManaged public var temperatureHigh: NSNumber
    @NSManaged public var temperatureLow: NSNumber

    convenience init() {
        self.init(entity: "WeeklyDay", shouldGenerateId: true)
    }
    
    public func getSummary() -> String {
        return ""
    }
    
    public func getImageId() -> String {
        return imageId ?? ""
    }
    
    public func getId() -> NSObject {
        return id ?? -1
    }
}

