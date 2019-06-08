//
//  AppDelegate.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/2/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let networkManager = NetworkManager(provider: MoyaProvider<KastaAPI>())
        window!.rootViewController = ViewController(networkManager: networkManager)
        window!.makeKeyAndVisible()
        
        return true
    }
    
}

