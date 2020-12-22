//
//  Hourlies.swift
//  CoreDataKit
//
//  Created by Nik on 22.12.2020.
//

import UIKit
import CoreData

public class Hourlies: DBEntity, ITitle {
    
    @NSManaged public var date: String?
    @NSManaged public var imageId: String?
    @NSManaged public var temperature: NSNumber
    @NSManaged public var weatherId: NSNumber

    convenience init() {
        self.init(entity: "Hourlies", shouldGenerateId: true)
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

