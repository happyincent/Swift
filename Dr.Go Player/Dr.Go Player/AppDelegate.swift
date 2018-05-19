//
//  AppDelegate.swift
//  DrGoCast
//
//  Created by ddl on 2018/1/7.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit
import EZPlayer
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // facebook
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UIApplication.shared.isStatusBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        
        let nav = UINavigationController(rootViewController: Login())
        
        self.window!.rootViewController = nav
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if self.window?.rootViewController?.presentedViewController is EZPlayerFullScreenViewController {
            return UIInterfaceOrientationMask.all
        } else {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        // facebook
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(SDKSettings.appId)") && url.host == "authorize" {
            return SDKApplicationDelegate.shared.application(application, open: url, options: options)
        }
        return false
    }
    
}
