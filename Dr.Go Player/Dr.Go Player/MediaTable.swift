//
//  MediaTable.swift
//  DrGoCast
//
//  Created by ddl on 2018/1/8.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit
import FacebookLogin

class MediaTable: UITableViewController {
    
    var mediaInfo :[AnyObject]! = nil
    var lastIndex :Int = -1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lastIndex = self.mediaInfo.index(where: { URL(string: $0["URL"] as? String ?? "") == MediaManager.sharedInstance.player?.contentURL }) ?? -1
        self.tableView.cellForRow(at: IndexPath(row: self.lastIndex, section: 0))?.backgroundColor = UIColor.lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        
        // logout
        let logoutButton = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(self.logoutButtonAction))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logoutButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        MediaManager.sharedInstance.releasePlayer()
        LoginManager().logOut() // facebook
    }
    
    // MARK: - navigation to PlayerMain
    func navMediaView(_ index: Int) {
        let nextView = PlayerMain()
        
        nextView.videoInfo = [
            "title": self.mediaInfo[index]["title"] as? String ?? "",
            "URL": self.mediaInfo[index]["URL"] as? String ?? ""
        ]
        
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    // MARK: - TableView delegate
    // tableView 有幾個cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.mediaInfo==nil) ? 1 : self.mediaInfo.count
    }
    
    // tableView 顯示內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 目前要顯示的的cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        // 初始化 ( 箭頭、背景顏色 )
        cell!.accessoryType = .disclosureIndicator
        cell?.backgroundColor = UIColor.clear
        
        // 第index筆
        cell?.textLabel?.text = self.mediaInfo[indexPath.row]["title"] as? String ?? ""
        
        if indexPath.row == self.lastIndex {
            cell?.backgroundColor = UIColor.lightGray
        }
        
        return cell!
    }
    
    // tableView 點選後執行動作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消點選狀態
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 初始化 ( 背景顏色 )
        self.tableView.cellForRow(at: IndexPath(row: self.lastIndex, section: 0))?.backgroundColor = UIColor.clear
        
        // 第index筆
        print("mediaTable selected:", indexPath.row)
        self.navMediaView(indexPath.row)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

