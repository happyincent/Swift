//
//  URLSessionExtensions.swift
//  古蹟x歷史建築
//
//  Created by ddl on 2017/10/15.
//  Copyright © 2017年 ddl. All rights reserved.
//

import UIKit

extension BaseViewController: URLSessionDownloadDelegate {
    
    // urlSession 下載完成
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("下載完成")
        
        let fileUrl = URL(string: self.filePath)!
        do {
            let data = try? Data(contentsOf: location)
            try data?.write(to: fileUrl, options: .atomic)
            print("urlSession: success")
            
            _ = self.jsonParse(fileUrl)
            
        } catch {
            print("urlSession: fail")
        }
    }
    
    // urlSession 下載中
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("urlSession: \(totalBytesWritten)/\(totalBytesExpectedToWrite)")
    }
}
