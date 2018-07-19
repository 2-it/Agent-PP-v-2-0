//
//  AppDelegate.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 12.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import UIKit

import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        // print(Realm.Configuration.defaultConfiguration.fileURL)
  
        do{
            _ = try Realm()
        
        }catch{
            print("Ошибка подключения к Realm \(error)")
        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
       

    }



}

