//
//  ImageCell.swift
//  AsyncPhotos
//
//  Created by Andrew James on 1/24/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell
{
    override func prepareForReuse()
    {
        imageView?.cancelDownload()
        imageView?.image = nil
    }
}
