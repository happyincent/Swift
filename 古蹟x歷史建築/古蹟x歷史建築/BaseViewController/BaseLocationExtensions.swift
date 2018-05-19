//
//  BaseLocationExtensions.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/10/25.
//  Copyright © 2017年 ddl. All rights reserved.
//

import CoreLocation

extension BaseViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            print("locationManager: authorizedWhenInUse")
            if self.myTableView != nil {
                print("locationmanager: startUpdatingLocation...")
                self.myLocationManager.startUpdatingLocation()
            }
        } else {
            print("locationManger: Not authorized, reloadData")
            self.myLocation = nil
            self.distance.removeAll()
            if self.myTableView != nil {
                self.myTableView.reloadData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation :CLLocation = locations[0] as CLLocation
        self.myLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        
        DispatchQueue.main.async {
            while self.apiData == nil {}
            self.setupDistance(self.myLocation)
            print("locationManager: reloadData")
            self.myTableView.reloadData()
        }
    }
    
    func setupDistance(_ location:CLLocation!) {
        guard let myLocation = location else {
            return
        }
        guard let dict = self.apiData else {
            return
        }
        
        self.distance.removeAll()
        
        for i in 0...dict.count-1 {
            
            let thisLocation = CLLocation(
                latitude: Double(dict[i]["latitude"] as? String ?? "0.0")!,
                longitude: Double(dict[i]["longitude"] as? String ?? "0.0")!
            )

            let value = (myLocation.distance(from: thisLocation) == 0.0) ? 100000000.0 : myLocation.distance(from: thisLocation)
            self.distance.append((i, value))
        }

        self.distance = self.distance.sorted(by: {$0.value < $1.value})
    }
    
}
