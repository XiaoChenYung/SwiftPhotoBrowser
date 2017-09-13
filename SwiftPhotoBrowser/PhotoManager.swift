//
//  PhotoManager.swift
//  SwiftPhotoBrowserDemo
//
//  Created by tm on 2017/9/13.
//  Copyright © 2017年 tm. All rights reserved.
//

import Foundation
import Photos
import Kingfisher

enum SelType {
    case Photo
    case Video
    case PhotoAndVideo
}

enum CameraType {
    case HalfScreen
    case FullScreen
    case System
}

public typealias FetchAlbumCallback = ((_ albums: Array<Album>) -> Void)

class PhotoManager {
    
    
    
    func fetchAllAlbum(callback: FetchAlbumCallback) {
        let smart = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        smart.enumerateObjects(options: .concurrent) { (collection, idx, stop) in
            let option = PHFetchOptions()
            option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        }
        
        
    }
}
