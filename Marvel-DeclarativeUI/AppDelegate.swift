//
//  AppDelegate.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainCoordinator: MainlyCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainCoordinator = MainlyCoordinator()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator?.navigator.viewController
        window?.makeKeyAndVisible()
                
        mainCoordinator?.start()
        return true
    }
}

