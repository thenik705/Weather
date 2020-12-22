//
//  AppDelegate.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
import CoreDataKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CoreDataManager.instance.setGroupIdentifier(Const.GROUP_ID)

        print("---------------------------------------------------/n/n")
        print("Documen")
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!)
        print("GroupID")
        print(FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Const.GROUP_ID)!)
        print("---------------------------------------------------/n/n")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

