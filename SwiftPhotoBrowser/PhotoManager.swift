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

public enum SeletedType {
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
public typealias FetchPhotosCallback = ((_ photos: Array<Photo>, _ video: Array<Photo>,_ objs: Array<Photo>) -> Void)

public class PhotoManager {
    
    var saveTempPhotos: Bool = false // if save temp photos
    var localImages: Array<UIImage>?
    var seveSystemAlbum: Bool = false
    var maxVideoDuration: TimeInterval = 300.0
    var cacheAlbum: Bool = true
    var monitorSystemAlbum: Bool = true
    var singleSeleted: Bool = false
    var singleSeleteClip: Bool = true
    var open3DTouchPreview: Bool = false
    var cameraType: CameraType = .HalfScreen
    var showAlertWhenDelNetPhoto: Bool = false
    var netPhotosURLs: Array<Any>?
    var outerCamera: Bool = false
    var openCamera: Bool = true
    var lookLivePhoto: Bool = false
    var separatePhotoAndVideo: Bool = false
    var goCamera: Bool = false
    var maxCount: Int = 10
    var maxPhotoCount: Int = 9
    var maxVideoCount: Int = 1
    var selTogether: Bool = true
    var rowCount: Int = 4
    
    var albums = Array<Album>()
    var selectedList = Array<Photo>()
    var selectedPhotos = Array<Album>()
    var selectedVideos = Array<Album>()
    var cameraList = Array<Album>()
    var cameraPhotos = Array<Album>()
    var cameraVideos = Array<Album>()
    var endCameraList = Array<Album>()
    var endCameraPhotos = Array<Album>()
    var endCameraVideos = Array<Album>()
    var selectedCameraList = Array<Album>()
    var selectedCameraPhotos = Array<Album>()
    var selectedCameraVideos = Array<Album>()
    var endSelectedCameraList = Array<Album>()
    var endSelectedCameraPhotos = Array<Album>()
    var endSelectedCameraVideos = Array<Album>()
    var endSelectedList = Array<Album>()
    var endSelectedPhotos = Array<Album>()
    var endSelectedVideos = Array<Album>()
    
    var type: SeletedType = .Photo
    
    var original: Bool = false
    var endOriginal: Bool = false
    var seletePhoto: Bool = false
    var cameraPhoto: Bool = false
    
    var tempAlbum: Album?
    
    public init() {
        
    }
    
//    public func
    
    /// get albums
    ///
    /// - Parameters:
    ///   - callback: callback
    ///   - showSeletedTag:
    public func fetchAllAlbum(callback: FetchAlbumCallback?, showSeletedTag: Bool) {
        let smart = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        smart.enumerateObjects(options: .concurrent) { (collection, idx, stop) in
            let option = PHFetchOptions()
            option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            switch self.type {
            case .Photo:
                option.predicate = NSPredicate(format: "mediaType == %d",  Int8(PHAssetMediaType.image.rawValue))
                break
            case .Video:
                option.predicate = NSPredicate(format: "mediaType == %d", Int8(PHAssetMediaType.video.rawValue))
                break
            default: break
            }
            let result = PHAsset.fetchAssets(in: collection, options: option)
            print(collection.localizedTitle! + "\(result.count)")
            if result.count > 0 && collection.localizedTitle != "Recently Deleted" {
                var albumModel = Album()
                albumModel.count = result.count
                albumModel.name = collection.localizedTitle
                albumModel.result = result
                if collection.localizedTitle == "Camera Roll" || collection.localizedTitle == "All Photos" {
                    self.albums.insert(albumModel, at: 0)
                } else {
                    self.albums.append(albumModel)
                }
                if showSeletedTag {
                    if self.selectedList.count > 0 {
                        let photo = self.selectedList.first
                        result.enumerateObjects(options: .concurrent, using: { (asset, idx, stop) in
                            if asset.localIdentifier == photo?.asset?.localIdentifier {
                                albumModel.selCount += 1
                                stop.pointee = false
                            }
                        })
                    }
                }
            }
        }
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumUserLibrary, options: nil)
        userAlbums.enumerateObjects(options: .concurrent) { (collection, idx, stop) in
            let option = PHFetchOptions()
            option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            if self.type == .Photo {
                option.predicate = NSPredicate(format: "mediaType == %ld", [PHAssetMediaType.image])
            } else if self.type == .Video {
                option.predicate = NSPredicate(format: "mediaType == %ld", [PHAssetMediaType.video])
            }
            let result = PHAsset.fetchAssets(in: collection, options: option)
            if result.count > 0 {
                var album = Album()
                album.count = result.count
                album.name = collection.localizedTitle
                album.result = result
                self.albums.append(album)
                if showSeletedTag {
                    if self.selectedList.count > 0 {
                        let photo = self.selectedList.first
                        result.enumerateObjects(options: .concurrent, using: { (asset, idx, stop) in
                            if asset.localIdentifier == photo?.asset?.localIdentifier {
                                album.selCount += 1
                                stop.pointee = false
                            }
                        })
                    }
                }
            }
        }
        
        for (index, obj) in self.albums.enumerated() {
            var album = obj
            album.index = index
            if showSeletedTag {
                if index == 0 {
                    album.selCount += self.selectedList.count
                }
            }
        }
        if callback != nil {
            callback!(self.albums)
        }
    }
    
    
    func fetchPhotosWithResult(result: PHFetchResult<PHAsset>, index: Int, callback: FetchPhotosCallback?) {
        var photos = Array<Photo>()
        var videos = Array<Photo>()
        var objs = Array<Photo>()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
