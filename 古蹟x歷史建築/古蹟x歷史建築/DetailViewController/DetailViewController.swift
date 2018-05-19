//
//  DetailViewController.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/10/19.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var name :String!
    var longitude :Double = 0.0
    var latitude :Double = 0.0
    var info :[String:String] = [:]
    var keys :[String] = []
    
    var tabBarSize :CGFloat!
    let fullScreenSize = UIScreen.main.bounds.size
    
    var myTableView :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        
        // TableView
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height - tabBarSize), style: .plain)
        self.myTableView.allowsSelection = false
        self.myTableView.isScrollEnabled = false
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell") // 重複使用 cell
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        // MapViewExtensions
        if [longitude, latitude] != [0.0, 0.0] {
            if longitude < latitude {
                swap(&longitude, &latitude)
            }
            self.myTableView.tableFooterView = self.setupMapView()
        }
        
        // sort info's keys
        if self.info.count > 0 {
            self.keys = Array(self.info.keys.sorted{$0.localizedStandardCompare($1) == .orderedAscending})
        }
        
        self.view.addSubview(self.myTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // section 幾個
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // section 背景顏色
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    // section 的標題
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "相關資訊"
        }
        return "位置"
    }
    
    // cell 幾個
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.info.count
        }
        return 1
    }
    
    // cell 內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        
        if let myLabel = cell.textLabel {
            if indexPath.row < self.info.count && indexPath.section == 0 {
                let key = (self.keys[indexPath.row].components(separatedBy: ",").last) ?? ""
                let val = self.info[ self.keys[indexPath.row] ] ?? ""
                myLabel.text = key + "：" + val
            } else {
                myLabel.text = "(" + String(format: "%.3f", self.longitude) + ", " + String(format: "%.3f", self.latitude) + ")"
            }
        }
        
        return cell
    }
    
}
