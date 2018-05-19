//
//  SecondViewController.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/9/26.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

class HistoricalSiteViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataUrl = "https://cloud.culture.tw/frontsite/trans/emapOpenDataAction.do?method=exportEmapJson&typeId=A&classifyId=1.2"
        self.filePath = self.rootPath + "historicalsite.json"
        self.showTalbe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

