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

public enum SelType {
    case Photo
    case Video
    case PhotoAndVideo
}

public enum CameraType {
    case HalfScreen
    case FullScreen
    case System
}

public typealias FetchAlbumCallback = ((_ albums: Array<Album>) -> Void)

public struct PhotoManager {
//    var saveTempPhotos: Bool = false // if save temp photos
//    var localImages: Array<UIImage>?
//    var seveSystemAlbum: Bool = false
    var maxVideoDuration: TimeInterval = 300.0
    var cacheAlbum: Bool = true
    var monitorSystemAlbum: Bool = true
    var singleSeleted: Bool = false
    var singleSeleteClip: Bool = true
    public var type: SelType = .Photo
//    var open3DTouchPreview: Bool = false
//    var cameraType: CameraType = .HalfScreen
//    var showAlertWhenDelNetPhoto: Bool = false
//    var netPhotosURLs: Array<Any>?
//    var outerCamera: Bool = false
//    var openCamera: Bool = true
//    var lookLivePhoto: Bool = false
//    var separatePhotoAndVideo: Bool = false
//    var goCamera: Bool = false
//    var maxCount: Int = 10
//    var maxPhotoCount: Int = 9
//    var maxVideoCount: Int = 1
//    var selTogether: Bool = true
//    var rowCount: Int = 4
//    
//    var selList: Array<Any>?
    
    public init() {
        
    }
    
    public func fetchAllAlbum(callback: FetchAlbumCallback) {
        let smart = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        smart.enumerateObjects(options: .concurrent) { (collection, idx, stop) in
            let option = PHFetchOptions()
            option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            switch self.type {
            case .Photo:
                option.predicate = NSPredicate(format: "mediaType == %ld", [PHAssetMediaType.image])
                break
            case .Video:
                option.predicate = NSPredicate(format: "mediaType == %ld", [PHAssetMediaType.video])
                break
            default: break
            }
            let result = PHAsset.fetchAssets(in: collection, options: option)
            print(result)
//            if result.count > 0 && collection.
        }
        
        
    }
}
