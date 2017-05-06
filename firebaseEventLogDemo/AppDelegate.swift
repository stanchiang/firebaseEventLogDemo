//
//  AppDelegate.swift
//  firebaseEventLogDemo
//
//  Created by Stanley Chiang on 4/30/17.
//  Copyright © 2017 Stanley Chiang. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = ViewController()
        window?.rootViewController = ImageEditorViewController()
        window?.makeKeyAndVisible()
        
        FIRApp.configure()
        
        return true
    }

}

