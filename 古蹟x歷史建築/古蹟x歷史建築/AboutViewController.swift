//
//  DetailViewController.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/10/19.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let fullScreenSize = UIScreen.main.bounds.size
    var myTableView :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height), style: .plain)
        self.myTableView.allowsSelection = true
        self.myTableView.isScrollEnabled = false
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        self.view.addSubview(self.myTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
            return "資料來源"
        }
        return "作者"
    }
    
    // cell 幾個
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 1
    }
    
    // cell 內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 目前要顯示的的cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        if let myLabel = cell?.textLabel {
            if indexPath.section == 0 && indexPath.row == 0 {
                cell?.accessoryType = .disclosureIndicator
                myLabel.text = "文資局古蹟"
            } else if indexPath.section == 0 && indexPath.row == 1 {
                cell?.accessoryType = .disclosureIndicator
                myLabel.text = "文資局歷史建築"
            } else if indexPath.section == 0 && indexPath.row == 2 {
                cell?.accessoryType = .disclosureIndicator
                myLabel.text = "flaticon.com"
            } else if indexPath.section == 1 && indexPath.row == 0 {
                myLabel.text = "ddl @ ITLab.NCKU"
            }
        }
        
        return cell!
    }
    
    // tableView 點選後執行動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消點選狀態
        tableView.deselectRow(at: indexPath, animated: true)
        
        var URL :String!
        
        if indexPath.section == 0 && indexPath.row == 0 {
            URL = "https://data.gov.tw/dataset/6246"
        } else if indexPath.section == 0 && indexPath.row == 1 {
            URL = "https://data.gov.tw/dataset/6965"
        } else if indexPath.section == 0 && indexPath.row == 2 {
            URL = "https://www.flaticon.com/"
        }
        
        UIApplication.shared.openURL(NSURL(string:URL)! as URL)
    }
    
}
