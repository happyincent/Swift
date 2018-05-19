//
//  AppDelegate.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/9/26.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.isStatusBarHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let myTabBar = UITabBarController()
        
        // 古蹟
        let monumentView = UINavigationController(rootViewController: MonumentViewController())
        monumentView.tabBarItem = UITabBarItem(title: "古蹟", image: #imageLiteral(resourceName: "first"), tag:1)
        
        // 歷史建築
        let historicalSiteView = UINavigationController(rootViewController: HistoricalSiteViewController())
        historicalSiteView.tabBarItem = UITabBarItem(title: "歷史建築", image: #imageLiteral(resourceName: "second"), tag:2)
        
        // 關於
        let aboutView = UINavigationController(rootViewController: AboutViewController())
        aboutView.tabBarItem = UITabBarItem(title: "關於", image: #imageLiteral(resourceName: "third"), tag:3)
        
        // 加到 UITabBarController
        myTabBar.viewControllers = [monumentView, historicalSiteView, aboutView]
        
        self.window!.rootViewController = myTabBar
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
}

