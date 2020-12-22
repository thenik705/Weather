//
//  ITitle.swift
//  CoreDataKit
//
//  Created by Nik on 22.12.2020.
//

import Foundation

@objc public protocol ITitle: AnyObject {
    
    func  getId() -> NSObject
    func  getSummary() -> String
}



