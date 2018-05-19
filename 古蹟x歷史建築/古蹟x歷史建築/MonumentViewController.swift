//
//  FirstViewController.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/9/26.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

class MonumentViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataUrl = "https://cloud.culture.tw/frontsite/trans/emapOpenDataAction.do?method=exportEmapJson&typeId=A&classifyId=1.1"
        self.filePath = self.rootPath + "monument.json"
        self.showTalbe()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
