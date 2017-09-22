//
//  Album.swift
//  SwiftPhotoBrowserDemo
//
//  Created by tm on 2017/9/13.
//  Copyright © 2017年 tm. All rights reserved.
//

import Foundation
import Photos

public struct Album {
    var name: String? // album name
    var count: Int = 0 // photos count
    var asset: PHAsset? // cover asset
    var coverImage: UIImage?
    var result: PHFetchResult<AnyObject>? // photos set
    var index: Int = 0
    var selCount: Int = 0
    var nameWidth: Int = 0 // album name width
}
