//
//  AppDelegate.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/14/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = Realm.Configuration(schemaVersion: 5) { migration, oldSchemeVersion in
            
            if oldSchemeVersion < 1 {
                print("0 -> 1")
            } else if oldSchemeVersion < 2 {
                print("1 -> 2")
            } else if oldSchemeVersion < 3 {
                print("2 -> 3")
            } else if oldSchemeVersion < 4 {
                print("3 -> 4")
                migration.renameProperty(onType: Reminder.className(), from: "title", to: "reminderTitle")
            } else if oldSchemeVersion < 5 {
                migration.enumerateObjects(ofType: Reminder.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    new["count"] = 10
                }
            }
            
        }
        
        Realm.Configuration.defaultConfiguration = configuration
        
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

