//
//  ImageProvider.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 19/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class ImageProvider: NSObject {

    var loader: ImageLoader
    var cache: ImageCache
    
    override init() {
        self.loader = ImageLoader()
        self.cache = ImageCache()
        super.init()
    }
    
    typealias ProvideImageCompletition = (image: UIImage?, error: NSError?) -> Void
    
    func provideImage(imageUrl: NSURL, completition: ProvideImageCompletition) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let urlRequest = NSURLRequest(URL: imageUrl)
            if let image = self.cache.getImageForUrlRequest(urlRequest) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completition(image: image, error: nil)
                })
                return
            } else {
                self.loader.loadImage(urlRequest, completition: { (responce, data, error) -> Void in
                    guard let responce = responce, let data = data else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            completition(image: nil, error: error)
                        })
                        return
                    }
                    
                    self.cache.saveUrlResponce(responce, withData: data, forUrlRequest: urlRequest)
                    completition(image: UIImage(data: data), error: nil)
                })
            }
        }
    }
}
