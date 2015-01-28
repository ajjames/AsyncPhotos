//
//  MasterViewController.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/21/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController
{

    var detailViewController: DetailViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                let image = self.tableView.cellForRowAtIndexPath(indexPath)?.imageView?.image
                controller.someImage = image
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}


