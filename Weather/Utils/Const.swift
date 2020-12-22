//
//  Const.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation
import UIKit

class Const {

    // MARK: - Controller
    static var GET_STORYBOARD = UIStoryboard(name: "Main", bundle: nil)

    static var MAIN_VIEW_CONTROLLER = "MAIN_VIEW_CONTROLLER"
    static var DAYS_LIST_VIEW_CONTROLLER = "DAYS_LIST_VIEW_CONTROLLER"

    // MARK: - Config
    static var GROUP_ID = "group.com.nik.weather.container"
    
    // MARK: - Sort BD
    static var SORT_ID = [NSSortDescriptor(key: "id", ascending: true)]
    static var SORT_DATE_TIME = [NSSortDescriptor(key: "date", ascending: true)]
}
