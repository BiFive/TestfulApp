//
//  ImageLoader.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 19/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class ImageLoader: NSObject {

    let urlSession: NSURLSession
    
    override init() {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.HTTPMaximumConnectionsPerHost = 3
        self.urlSession = NSURLSession(configuration: sessionConfig)
        super.init()
    }
    
    typealias LoadImageCompletition = (responce: NSURLResponse?, data: NSData?, error: NSError?) -> Void
    
    func loadImage(urlRequest: NSURLRequest, completition: LoadImageCompletition) {
        let downloadTask = urlSession.downloadTaskWithRequest(urlRequest) { (url: NSURL?, responce: NSURLResponse?, error: NSError?) -> Void in
            let data: NSData?
            if let url = url {
                data = NSData(contentsOfURL: url)
            } else {
                data = nil
            }
            completition(responce: responce, data: data, error: error)
        }
        downloadTask.resume()
    }
}
