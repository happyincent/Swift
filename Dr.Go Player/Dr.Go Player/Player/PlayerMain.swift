//
//  PlayerMain.swift
//  DrGoCast
//
//  Created by ddl on 2018/1/13.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit
import FacebookLogin

class PlayerMain: UIViewController {
    
    var videoInfo :[String:String]! = nil
    
    let PlayerView = UIView()
    let PlayButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.orientation.isLandscape {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.videoInfo["title"] ?? ""
        
        // logout
        let logoutButton = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(self.logoutButtonAction))
        self.navigationItem.rightBarButtonItem = logoutButton
        
        // Setup PlayerView
        self.PlayerView.frame = CGRect(
            x: 0, y: self.navigationController?.navigationBar.frame.maxY ?? 0.0,
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.width * 9/16
        )
        self.PlayerView.backgroundColor = UIColor.darkGray
        
        // Setup PlayButton (draw above PlayerView)
        self.PlayButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.PlayButton.backgroundColor = UIColor.gray
        self.PlayButton.center = CGPoint(x: self.PlayerView.bounds.midX, y: self.PlayerView.bounds.midY);
        self.PlayButton.setTitle("▶︎", for: .normal)
        self.PlayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        self.PlayButton.setTitleColor(UIColor.white, for: .normal)
        self.PlayButton.addTarget(self, action: #selector(self.playButtonAction), for: .touchUpInside)
        
        self.PlayerView.addSubview(self.PlayButton)
        self.view.addSubview(self.PlayerView)
        
        // float to embedded
        if MediaManager.sharedInstance.player?.rate != 0 && MediaManager.sharedInstance.player?.contentURL == URL(string: self.videoInfo["URL"] ?? "")! {
            print("Keep playing:", self.videoInfo["title"] ?? "")
            MediaManager.sharedInstance.player?.embeddedContentView = self.PlayerView
            MediaManager.sharedInstance.player?.toEmbedded()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // ebedded to float
        if self.isMovingFromParentViewController {
            MediaManager.sharedInstance.player?.toFloat()
        }
    }
    
    @objc func logoutButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        MediaManager.sharedInstance.releasePlayer()
        LoginManager().logOut() // facebook
    }
    
    @objc func playButtonAction() {
        print("Start playing:", self.videoInfo["title"] ?? "")
        MediaManager.sharedInstance.playEmbeddedVideo(
            url: URL(string: self.videoInfo["URL"] ?? "")!,
            embeddedContentView: self.PlayerView
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
