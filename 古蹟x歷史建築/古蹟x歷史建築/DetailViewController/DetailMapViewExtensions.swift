//
//  MapViewController.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/10/20.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit
import MapKit

extension DetailViewController: CLLocationManagerDelegate, MKMapViewDelegate  {
    
    func setupMapView() -> MKMapView {
        
        let myMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: self.fullScreenSize.width, height: self.fullScreenSize.height*0.5))
        
        // 設置委任對象
        myMapView.delegate = self
        
        // 地圖樣式
        myMapView.mapType = .standard
        
        // 顯示自身位置
        myMapView.showsUserLocation = true
        
        // 允許縮放地圖
        myMapView.isZoomEnabled = true
        
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        // 設置地圖顯示的範圍與中心點座標
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        
        // 加入到畫面中
        self.view.addSubview(myMapView)
        
        // 建立一個地點圖示 (圖示預設為紅色大頭針)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        objectAnnotation.title = self.title
        myMapView.addAnnotation(objectAnnotation)
        
        return myMapView
    }
    
}
