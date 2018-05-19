//
//  Login-FB.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/2/12.
//  Copyright © 2018年 ddl. All rights reserved.
//

import FacebookCore
import FacebookLogin

extension Login {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Did complete login via LoginButton with result \(result)")
        self.fetchFBProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did logout via LoginButton")
    }
    
    struct FBProfileRequest: GraphRequestProtocol {
        typealias Response = GraphResponse
        
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, name"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = 2.7
    }
    
    func fetchFBProfile() {
        FBProfileRequest().start { (httpResponse, result) in
            switch result {
                case .success(let response):
                    print(response)
                    if let resDict = response.dictionaryValue {
                        UserDefaults.standard.set(resDict["name"], forKey: "KEY_name")
                        UserDefaults.standard.set(resDict["id"], forKey: "KEY_id")
                        UserDefaults.standard.synchronize()
                    }
                    self.loginCheck()
                
                case .failed(let error):
                    print(error)
                    let alertController = UIAlertController(title: "登入失敗", message: "error: \(error)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
