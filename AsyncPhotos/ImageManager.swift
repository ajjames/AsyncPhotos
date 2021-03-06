//
//  ImageManager.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/22/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit


public class ImageManager
{
    private class var imageCache: NSCache
    {
        struct Static
        {
            static var instance: NSCache?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = NSCache()
        }
        return Static.instance!
    }

    public class func getImageAsynchronously(url:NSURL, completionHandler:(image:UIImage?, error: NSError?)->())
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
            ImageManager.getImageSynchronously(url, cancelableOperation: nil, completionHandler: completionHandler)
        })
    }

    public class func getImageSynchronously(url:NSURL, cancelableOperation:NSOperation?, completionHandler:(image:UIImage?, error: NSError?)->())
    {
        let isCancelled = cancelableOperation?.cancelled ?? false
        if isCancelled
        {
            self.hideNetworkActivity()
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(image: nil, error: nil)
            }
        }

        showNetworkActivity()
        var image:UIImage?
        var returnError:NSError?

        if let cachedImage = self.imageCache.objectForKey(url) as? UIImage
        {
            image = cachedImage
        }
        else if let data = self.fetchDataSyncronously(url)
        {
            image = UIImage(data: data)
            if image != nil
            {
                self.imageCache.setObject(image!, forKey: url)
            }
        }

        if image == nil
        {
            returnError = NSError(domain:"Error: unable to load image", code:0, userInfo:nil)
        }

        self.hideNetworkActivity()
        dispatch_async(dispatch_get_main_queue()) {
            completionHandler(image:image,error:returnError)
        }
    }

    public class func fetchDataSyncronously(url:NSURL) -> NSData?
    {
        var request: NSURLRequest = NSURLRequest(URL: url)
        var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
        var response: NSURLResponse?
        var error:NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        if (error != nil)
        {
            println(error!.description)
        }
        return data
    }

    private class func showNetworkActivity()
    {
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
    }

    private class func hideNetworkActivity()
    {
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
}