//
//  CourseBaseTable.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/29.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit

class CourseBaseTable: UITableViewController {
    
    var titleName :String!
    var dataName :String!
    var data :[String : [AnyObject]]! = nil
    var keys :[String]! = nil
    
    var table :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        
        // parse json file
        if let path = Bundle.main.path(forResource: self.dataName, ofType: "json") {
            self.jsonParse( path )
        }
        
        if self.data != nil {
            self.keys = Array(self.data.keys.sorted{$0.localizedStandardCompare($1) == .orderedAscending})
        }
    }
    
    // MARK: - Read JSON File
    func jsonParse(_ path :String) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let dict = try JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.allowFragments
                ) as! [String : [AnyObject]]
            self.data = dict
            print("total:", self.data.count)
        } catch let error as NSError {
            print("CourseBaseTable: jsonParse:", error.localizedDescription)
        }
    }
    
    // MARK: - TableView delegate
    // cell 幾個
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data==nil) ? 1 : self.data.count
    }
    
    // cell 內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 目前要顯示的的cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        // 顯示箭頭( > )
        cell!.accessoryType = .disclosureIndicator
        
        // 第index筆
        cell?.textLabel?.text = (self.keys==nil) ? "none" : self.keys[indexPath.row]
        
        return cell!
    }
    
    // tableView 點選後執行動作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 第index筆
        let index = indexPath.row
        print("CouseBaseTable selected:", index)
        
        guard (self.data != nil && self.keys != nil) else {
            return
        }
        
        let key = self.keys[index]
        let data = self.data[key]
        
        let nextView = MediaTable()
        nextView.title = self.titleName + " - " + key
        nextView.mediaInfo = data
        
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
