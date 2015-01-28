//
//  UIImageView-Extension.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/28/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC


var AssociatedObjectHandle_downloader: UInt8 = 0
var AssociatedObjectHandle_downloaderUrl: UInt8 = 0


public extension UIImageView
{

    public func downloadImageAsync(url:NSURL, completion:(imageView:UIImageView)->())
    {
        downloaderUrl = url
        cancelDownload()
        var imageView = self
        downloader = Downloader(imageAtUrl: url, completion: { (image, error) -> () in
            if error != nil
            {
                println(error!.description)
            }
            if imageView.downloaderUrl == url
            {
                imageView.downloader = nil
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    imageView.image = image
                    completion(imageView: imageView)
                })
            }
            else
            {
                completion(imageView: imageView)
            }
        })
        self.downloader?.start()
    }

    public func cancelDownload()
    {
        self.downloader?.cancel()
    }


    //--------------------------------------------------------------------------------------------------------
    // BELOW:
    // Contains objective-C voodoo until Swift offers first-class support for stored properties in extensions
    //--------------------------------------------------------------------------------------------------------

    private var downloader: Downloader?
    {
        get
        {
            if let downloaderObject = objc_getAssociatedObject(self, &AssociatedObjectHandle_downloader) as? Downloader
            {
                return downloaderObject
            }
            else
            {
                return nil
            }
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedObjectHandle_downloader, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }

    private var downloaderUrl: NSURL?
        {
        get
        {
            if let downloaderUrlObject = objc_getAssociatedObject(self, &AssociatedObjectHandle_downloaderUrl) as? NSURL
            {
                return downloaderUrlObject
            }
            else
            {
                return nil
            }
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedObjectHandle_downloaderUrl, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }

}