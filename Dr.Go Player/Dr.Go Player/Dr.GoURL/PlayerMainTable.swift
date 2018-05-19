//
//  PlayerMainTable.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/31.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit

class PlayerMainTable: UITableViewController {
    
    var videoInfo :[String:String]! = nil
    
    let playerWidth = UIScreen.main.bounds.size.width
    let playerHeight = UIScreen.main.bounds.size.width * 9/16
    
    let PlayerView = UIView()
    let PlayButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.title = self.videoInfo["title"] ?? ""
        
        // Property
        let originY = self.navigationController?.navigationBar.frame.maxY ?? 0.0
        let playerWidth = self.view.bounds.width
        let playerHeight = self.view.bounds.width * 9/16
        
        // Setup PlayerView
        self.PlayerView.frame = CGRect(x: 0, y: originY, width: playerWidth, height: playerHeight)
        self.PlayerView.backgroundColor = UIColor.darkGray
        
        // Setup PlayButton (draw above PlayerView)
        self.PlayButton.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.PlayButton.backgroundColor = UIColor.gray
        self.PlayButton.center = CGPoint(x: self.PlayerView.bounds.midX, y: self.PlayerView.bounds.midY);
        self.PlayButton.setTitle("▶︎", for: .normal)
        self.PlayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        self.PlayButton.setTitleColor(UIColor.white, for: .normal)
        self.PlayButton.addTarget(self, action: #selector(self.playButtonAction), for: .touchUpInside)
        
        self.PlayerView.addSubview(self.PlayButton)
        self.tableView.tableHeaderView = self.PlayerView
        
        if MediaManager.sharedInstance.player?.rate != 0 && MediaManager.sharedInstance.player?.contentURL == URL(string: self.videoInfo["URL"] ?? "")! {
            print("Keep playing:", self.videoInfo["title"] ?? "")
            MediaManager.sharedInstance.player?.embeddedContentView = self.PlayerView
            MediaManager.sharedInstance.player?.toEmbedded()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParentViewController {
            MediaManager.sharedInstance.player?.toFloat()
        }
    }
    
    @objc func playButtonAction() {
        print("Start playing:", self.videoInfo["title"] ?? "")
        MediaManager.sharedInstance.playEmbeddedVideo(
            url: URL(string: self.videoInfo["URL"] ?? "")!,
            embeddedContentView: self.PlayerView
        )
    }
    
    // MARK: - TableView delegate
    // tableView 有幾個cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // tableView 顯示內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 目前要顯示的的cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text = "table cell \(indexPath.row)"
        
        return cell!
    }
    
    // tableView 點選後執行動作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消點選狀態
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
