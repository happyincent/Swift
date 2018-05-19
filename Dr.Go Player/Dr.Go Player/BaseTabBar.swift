//
//  BaseTabBar.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/29.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit
import FacebookLogin

class BaseTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        if UserDefaults.standard.object(forKey: "KEY_name") != nil {
            let username = UserDefaults.standard.string(forKey: "KEY_name") ?? "error"
            self.title = "主畫面 (" + username + ")"
            self.view.makeToast("Welcome to the Player.",
                                point: CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.7),
                                title: "Hello, " + username + "!",
                                image: #imageLiteral(resourceName: "Welcome"), completion: nil)
        }
        
        // logout
        let logoutButton = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(self.logoutButtonAction))
        self.navigationItem.rightBarButtonItem = logoutButton
        
        //tabbar
        let subjectView = BaseSubjectTable()
        subjectView.tabBarItem = UITabBarItem(title: "課程列表", image: #imageLiteral(resourceName: "BaseSubject"), tag: 1)
        
        let bookmarkView = BaseBookmarkTable()
        bookmarkView.tabBarItem = UITabBarItem(title: "我的最愛", image: #imageLiteral(resourceName: "BaseBookmark"), tag: 2)
        
        let recordView = BaseRecordTable()
        recordView.tabBarItem = UITabBarItem(title: "學習履歷", image: #imageLiteral(resourceName: "BaseRecord"), tag: 3)
        
        self.viewControllers = [subjectView, bookmarkView, recordView]
    }
    
    @objc func logoutButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        MediaManager.sharedInstance.releasePlayer()
        LoginManager().logOut() // facebook
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
