//
//  TableViewExtensions.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/10/15.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

extension BaseViewController: UITableViewDataSource {
    
    // tableView 有幾個cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            print("match:", self.searchArr.count)
            return self.searchArr.count
        } else if self.apiData != nil {
            return self.apiData.count
        } else {
            return 0
        }
    }
    
    // tableView 顯示內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 目前要顯示的的cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        // 顯示箭頭( > )
        cell!.accessoryType = .disclosureIndicator
        
        // apiData中 第index筆
        var index :Int!
        if searchController.isActive && !self.searchArr.isEmpty {
            index = self.searchArr[indexPath.row]
        } else if !self.distance.isEmpty {
            index = self.distance[indexPath.row].index
        } else {
            index = indexPath.row
        }
        
        // 顯示 地點名稱
        if let myLabel = cell!.textLabel {
            myLabel.text = self.apiData[index]["name"] as? String
        }
        
        // 顯示 距離
        if let myDetail = cell!.detailTextLabel {
            if !self.distance.isEmpty {
                if let i = self.distance.index(where: {$0.index == index}) {
                    let distance = self.distance[i].value
                    if distance == 100000000.0 || (self.apiData[index]["longitude"] as? String ?? "").isEmpty {
                        myDetail.text = "ERROR"
                    } else if distance > 1000 {
                        myDetail.text = String(format:"%.2f", distance/1000) + " km"
                    } else {
                        myDetail.text = "\((Int)(distance)) m"
                    }
                }
            } else {
                myDetail.text = ""
            }
        }

        return cell!
    }
}

extension BaseViewController: UITableViewDelegate {
    // tableView 點選後執行動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消點選狀態
        tableView.deselectRow(at: indexPath, animated: true)
        
        // apiData中 第index筆
        var index :Int!
        if searchController.isActive && !self.searchArr.isEmpty {
            index = self.searchArr[indexPath.row]
        } else if !self.distance.isEmpty {
            index = self.distance[indexPath.row].index
        } else {
            index = indexPath.row
        }
        
        self.goDetail(index)
    }
}

extension BaseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        // 確認有值
        guard let searchText = searchController.searchBar.text else {
            return
        }
        guard let data = self.apiData else {
            return
        }
        
        // 清空searchArr
        self.searchArr.removeAll()
        
        // 加入名稱中包含searchText之地點的index
        for i in 0...data.count-1 {
            if (data[i]["name"] as! String).contains(searchText) {
                self.searchArr.append(i)
            }
        }
        
        // 重新整理TableView
        self.myTableView.reloadData()
    }
}
