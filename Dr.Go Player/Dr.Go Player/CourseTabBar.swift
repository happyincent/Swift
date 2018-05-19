//
//  CourseTabBar.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/29.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit
import FacebookLogin

class CourseTabBar: UITabBarController {
    
    var dataName :String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // logout
        let logoutButton = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(self.logoutButtonAction))
        self.navigationItem.rightBarButtonItem = logoutButton
        
        let gradeView = CourseGradeTable()
        gradeView.titleName = "(核心) \(self.title ?? "")"
        gradeView.dataName = self.dataName
        gradeView.tabBarItem = UITabBarItem(title: "核心課程", image: #imageLiteral(resourceName: "CourseGrade"), tag: 1)
        
        let topicView = CourseTopicTable()
        topicView.titleName = "(主題) \(self.title ?? "")"
        topicView.dataName = self.dataName + "_Topic"
        topicView.tabBarItem = UITabBarItem(title: "主題課程", image: #imageLiteral(resourceName: "CourseTopic"), tag: 2)
        
        self.viewControllers = [gradeView, topicView]
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
