//
//  ImageManager.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/22/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit

public class Downloader : NSObject
{
    private let operation: NSOperation

    public init(operation:NSOperation)
    {
        self.operation = operation
    }

    public convenience init(imageAtUrl imageUrl:NSURL, completion: ((image:UIImage?,error:NSError?)->())?)
    {
        var newOperation = NSBlockOperation()
        newOperation.addExecutionBlock { () -> Void in
            ImageManager.getImageSynchronously(imageUrl, cancelableOperation:newOperation) { (image, error) -> () in
                if let callback = completion
                {
                    callback(image: image, error: error)
                }
            }
        }
        self.init(operation: newOperation)
    }

    public func cancel()
    {
        if !operation.cancelled
        {
            operation.cancel()
        }
    }

    public func start()
    {
        var blockOperation = operation
        if blockOperation.ready
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                blockOperation.start()
            }
        }
    }
    
}


