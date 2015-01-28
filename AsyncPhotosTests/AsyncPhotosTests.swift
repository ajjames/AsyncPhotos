//
//  AsyncPhotosTests.swift
//  AsyncPhotosTests
//
//  Created by Andrew James on 1/21/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit
import XCTest
import AsyncPhotos

class AsyncPhotosTests: XCTestCase {
    
    override func setUp()
    {
        super.setUp()
        //
    }
    
    override func tearDown()
    {
        //
        super.tearDown()
    }
    
    func testDataDownloader()
    {
        var expectation = expectationWithDescription("should complete async call")
        let url = NSURL(string: "http://www.nasa.gov/images/content/222772main_a-516.jpg")!
        var newImage: UIImage?
        var downloader = Downloader(imageAtUrl: url) { (image, error) -> () in
            newImage = image
            expectation.fulfill()
        }
        downloader.start()
        waitForExpectationsWithTimeout(10.0, handler: { (error:NSError!) -> Void in
            XCTAssertNotNil(newImage)
        })
    }

    func testUIImageViewExtension()
    {
        var expectation = expectationWithDescription("should complete async call")
        let url = NSURL(string: "http://www.nasa.gov/images/content/222772main_a-516.jpg")!
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        imageView.downloadImageAsync(url, completion: { (imageView) -> () in
            expectation.fulfill()
        })

        waitForExpectationsWithTimeout(10.0, handler: { (error:NSError!) -> Void in
            XCTAssertTrue(imageView.image != nil)
            XCTAssertEqual(imageView.image?.size.width ?? 0.0, CGFloat(516.0))
        })

    }
}
