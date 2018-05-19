//
//  BaseSubjectTable.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/29.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit

class BaseSubjectTable: UITableViewController {
    
    let subjectList = ["國語", "英文", "數學", "自然","社會"]
    let dataNameList = ["DrGo_ES_Chinese", "DrGo_ES_English", "DrGo_ES_Math", "DrGo_ES_Science", "DrGo_ES_Sociology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
    }
    
    // MARK: - TableView delegate
    // cell 幾個
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjectList.count
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
        cell?.textLabel?.text = self.subjectList[indexPath.row]
        
        return cell!
    }
    
    // tableView 點選後執行動作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = CourseTabBar()
        nextView.title = self.subjectList[indexPath.row]
        nextView.dataName = self.dataNameList[indexPath.row]
        
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
