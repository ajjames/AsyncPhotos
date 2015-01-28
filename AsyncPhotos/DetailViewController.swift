//
//  DetailViewController.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/21/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet var imageView: UIImageView!
    var someImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        if let image = someImage
        {
            imageView.image = image
        }
    }

}

