//
//  PhotoDataSource.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/25/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit

class PhotoDataSource : NSObject, UITableViewDataSource
{
    var detailViewController: DetailViewController? = nil
    var imageUrls:[String] = [
        "http://www.nasa.gov/images/content/222772main_a-516.jpg",
        "http://www.nasa.gov/images/content/576194main_s84-27017-4x3_516-387.jpg",
        "http://photojournal.jpl.nasa.gov/jpeg/PIA03243.jpg",
        "http://photojournal.jpl.nasa.gov/jpeg/PIA11796.jpg",
        "http://www.jpl.nasa.gov/spaceimages/images/mediumsize/PIA09108_ip.jpg",
        "http://www.nasa.gov/images/content/619926main_sts-71_docked.jpg",
        "http://www.nasa.gov/images/content/114270main_spitzer-050405-browse.jpg",
        "http://iswa.ccmc.gsfc.nasa.gov/IswaSystemWebApp/iSWACygnetStreamer?timestamp=2012-07-17%2016:31:34&window=0&cygnetId=241",
        "http://www.nasa.gov/images/content/222772main_a-516.jpg",
        "http://www.nasa.gov/images/content/576194main_s84-27017-4x3_516-387.jpg",
        "http://photojournal.jpl.nasa.gov/jpeg/PIA03243.jpg",
        "http://photojournal.jpl.nasa.gov/jpeg/PIA11796.jpg",
        "http://www.jpl.nasa.gov/spaceimages/images/mediumsize/PIA09108_ip.jpg",
        "http://www.nasa.gov/images/content/619926main_sts-71_docked.jpg",
        "http://www.nasa.gov/images/content/114270main_spitzer-050405-browse.jpg",
        "http://iswa.ccmc.gsfc.nasa.gov/IswaSystemWebApp/iSWACygnetStreamer?timestamp=2012-07-17%2016:31:34&window=0&cygnetId=241",
        "http://www.nasa.gov/images/content/222772main_a-516.jpg",
        "http://www.nasa.gov/images/content/576194main_s84-27017-4x3_516-387.jpg",
        "http://photojournal.jpl.nasa.gov/jpeg/PIA03243.jpg",
        "http://photojournal.jpl.nasa.gov/jpeg/PIA11796.jpg",
        "http://www.jpl.nasa.gov/spaceimages/images/mediumsize/PIA09108_ip.jpg",
        "http://www.nasa.gov/images/content/619926main_sts-71_docked.jpg",
        "http://www.nasa.gov/images/content/114270main_spitzer-050405-browse.jpg",
        "http://iswa.ccmc.gsfc.nasa.gov/IswaSystemWebApp/iSWACygnetStreamer?timestamp=2012-07-17%2016:31:34&window=0&cygnetId=241"
    ]

    // MARK: - Table View

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ImageCell
        let urlString = imageUrls[Int(indexPath.row)]
        if let url = NSURL(string: urlString)
        {
            cell.imageView!.downloadImageAsync(url, completion: { (imageView) -> () in
                cell.setNeedsLayout()
            })
        }
        return cell
    }
}