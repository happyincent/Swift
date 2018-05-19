//
//  Login.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/29.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class Login: UIViewController, UITextFieldDelegate, LoginButtonDelegate {
    
    let screenSize = UIScreen.main.bounds.size
    
    var username :UITextField!
    var password :UITextField!
    var loginButton :UIButton!
    var FBLoginButton :LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登入"
        
        // property
        let textFieldWidth = 200
        let FieldHeight = 50
        let FieldSpace = FieldHeight + 20
        
        // username
        self.username = UITextField(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: FieldHeight))
        self.username.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.3)
        self.username.placeholder = "使用者名稱"
        self.username.borderStyle = .roundedRect
        self.username.clearButtonMode = .whileEditing
        self.username.keyboardType = .emailAddress
        self.username.returnKeyType = .next
        self.username.delegate = self
        
        // password
        self.password = UITextField(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: FieldHeight))
        self.password.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.3 + CGFloat(FieldSpace) * 1)
        self.password.placeholder = "密碼"
        self.password.borderStyle = .roundedRect
        self.password.clearButtonMode = .whileEditing
        self.password.returnKeyType = .done
        self.password.delegate = self
        
        // loginButton
        self.loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: FieldHeight))
        self.loginButton.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.3 + CGFloat(FieldSpace) * 2)
        self.loginButton.setTitle("登入", for: .normal)
        self.loginButton.setTitleColor(self.view.tintColor, for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        
        // FBLoginButton
        self.FBLoginButton = LoginButton(readPermissions: [.publicProfile, .email])
        self.FBLoginButton.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.3 + CGFloat(FieldSpace) * 3)
        self.FBLoginButton.delegate = self
        if let accessToken = AccessToken.current {
            print("View - Login:", accessToken.grantedPermissions as Any)
            self.fetchFBProfile()
        }
        
        self.view.addSubview(self.username)
        self.view.addSubview(self.password)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.FBLoginButton)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    @objc func loginAction() {
        let username = (self.username.text == "") ? "guest" : self.username.text
        UserDefaults.standard.set(username, forKey: "KEY_name")
        UserDefaults.standard.set("0000000000000000", forKey: "KEY_id")
        UserDefaults.standard.synchronize()
        self.loginCheck()
    }
    
    func loginCheck() {
        if UserDefaults.standard.object(forKey: "KEY_id") != nil &&
           UserDefaults.standard.object(forKey: "KEY_name") != nil {
            let nextView = BaseTabBar()
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
