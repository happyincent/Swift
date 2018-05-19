//
//  BaseViewController.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/9/29.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit
import CoreLocation

class BaseViewController: UIViewController {
    
    var dataUrl :String!
    var rootPath :String!
    var filePath :String!
    var apiData :[AnyObject]! = nil
    var searchArr :[Int] = []
    var distance :[(index: Int, value: Double)] = []
    var myLocation:CLLocation! = nil
    
    var myTableView :UITableView!
    var myActivityIndicator :UIActivityIndicatorView!
    var myButton :UIButton!
    var searchController :UISearchController!
    var myLocationManager :CLLocationManager!
    
    let fullScreenSize = UIScreen.main.bounds.size
    let tabBarSize = 49 as CGFloat
    let buttonSize = 30 as CGFloat
    let searchBarSize = 50 as CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.view.backgroundColor = UIColor.white
        
        // 應用程式儲存檔案的目錄路徑
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        rootPath = urls[urls.count-1].absoluteString
        
        // CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        if CLLocationManager.authorizationStatus() == .notDetermined {
            myLocationManager.requestWhenInUseAuthorization()
        }
        
        // 載入中 環狀進度條
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        myActivityIndicator.center = CGPoint(x: self.fullScreenSize.width * 0.5, y: self.fullScreenSize.height * 0.4)
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.startAnimating()
        
        // 重新整理 button
        myButton = UIButton( frame: CGRect(x: 0, y: self.fullScreenSize.height-(self.buttonSize+self.tabBarSize), width: self.fullScreenSize.width, height: self.buttonSize) )
        myButton.setTitle("更新資料", for: .normal)
        myButton.backgroundColor = UIColor.darkGray
        myButton.addTarget(self, action: #selector(self.updateTable), for: .touchUpInside)
        
        // 搜尋列
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.fullScreenSize.width, height: self.searchBarSize)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchResultsUpdater = self
        
        self.view.addSubview(searchController.searchBar)
        self.view.addSubview(myActivityIndicator)
        self.view.addSubview(myButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 更新並顯示table
        if let table = self.myTableView {
            myActivityIndicator.startAnimating()
            
            guard self.apiData != nil else {
                return
            }
            
            print("viewDidAppear: table.reloadData")
            table.reloadData()
            
            myActivityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        myLocationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*** 自定義 methods ***/
    
    func showTalbe() {
        if !( self.jsonParse(URL(string: self.filePath)!) ) {
            print("showTalbe: do normalGet")
            self.normalGet(self.dataUrl)
        }
    }
    
    func normalGet(_ myUrl :String) {
        if let url = URL(string: myUrl) {
            
            // URLSessionExtensions.swift
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: self,
                delegateQueue: nil
            )
            
            session.downloadTask(with: url).resume()
        }
    }
    
    func jsonParse(_ url :URL) -> Bool {
        do {
            let dict = try JSONSerialization.jsonObject(with: Data(contentsOf: url), options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
            print("總數:", dict.count)
            print("第一項:", dict[0]["name"] as! String)
            
            self.apiData = dict
            
            DispatchQueue.main.async {
                self.myActivityIndicator.stopAnimating()
                self.addTable()
            }
        } catch let error as NSError {
            print("jsonParse: " + error.localizedDescription)
            return false
        }
        
        return true
    }
    
    func addTable() {
        self.myTableView = UITableView(frame: CGRect(x: 0, y: self.searchBarSize, width: self.fullScreenSize.width, height: self.fullScreenSize.height-(tabBarSize+buttonSize+searchBarSize)), style: .plain)
        self.myTableView.allowsSelection = true
        
        // TableViewExtensions.swift
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        self.view.addSubview(self.myTableView)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("addTable: startUpdatingLocation...")
            self.myLocationManager.startUpdatingLocation()
        }
    }
    
    @objc func updateTable() {
        DispatchQueue.main.async {
            self.apiData = nil
            self.searchArr.removeAll()
            self.myButton.backgroundColor = UIColor.red
            print("updateTable: reloadData 1")
            self.myTableView.reloadData()
            self.view.bringSubview(toFront: self.myActivityIndicator)
            self.myActivityIndicator.startAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("updateTable: do normalGet")
            self.normalGet(self.dataUrl)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
            while self.apiData == nil {}
            self.setupDistance(self.myLocation)
            print("updateTable: reloadData 2")
            self.myTableView.reloadData()
            self.myButton.backgroundColor = UIColor.darkGray
        }
    }
    
    func goDetail(_ index: Int) {
        print("goDetail: \(index)")
        
        let data = self.apiData[index]
        let viewcontroller = DetailViewController()
        
        viewcontroller.tabBarSize = self.tabBarSize
        viewcontroller.name = data["name"] as? String ?? "error"
        viewcontroller.longitude = Double(data["longitude"] as? String ?? "0.0")!
        viewcontroller.latitude = Double(data["latitude"] as? String ?? "0.0")!
        
        viewcontroller.info = [
            "0,建造年份": data["buildingYearName"] as? String ?? "",
            "1,登記日期": data["registerDateValue_eng"] as? String ?? "",
            "2,地址": data["address"] as? String ?? "",
            "3,開放時間": data["openTime"] as? String ?? ""
            ].filter{ !$0.value.isEmpty }
        
        
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
}
