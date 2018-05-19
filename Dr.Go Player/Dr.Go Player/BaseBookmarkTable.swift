//
//  BaseBookmarkTable.swift
//  Dr.Go Player
//
//  Created by ddl on 2018/1/29.
//  Copyright © 2018年 ddl. All rights reserved.
//

import UIKit

class BaseBookmarkTable: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
