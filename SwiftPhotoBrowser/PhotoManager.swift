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
    
    public var spacing = 1.0 // 选择器中图片间距
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
    var fetchLivePhoto: Bool = false
    var fetchGifPhoto: Bool = false
    var separatePhotoAndVideo: Bool = false
    var goCamera: Bool = false
    var maxCount: Int = 10
    var maxPhotoCount: Int = 9
    var maxVideoCount: Int = 1
    var selTogether: Bool = true
    var rowCount: Int = 4
    
    var albums = Array<Album>()
    var selectedList = Array<Photo>()
    var selectedPhotos = Array<Photo>()
    var selectedVideos = Array<Photo>()
    var cameraList = Array<Photo>()
    var cameraPhotos = Array<Photo>()
    var cameraVideos = Array<Photo>()
    var endCameraList = Array<Photo>()
    var endCameraPhotos = Array<Photo>()
    var endCameraVideos = Array<Photo>()
    var selectedCameraList = Array<Photo>()
    var selectedCameraPhotos = Array<Photo>()
    var selectedCameraVideos = Array<Photo>()
    var endSelectedCameraList = Array<Photo>()
    var endSelectedCameraPhotos = Array<Photo>()
    var endSelectedCameraVideos = Array<Photo>()
    var endSelectedList = Array<Photo>()
    var endSelectedPhotos = Array<Photo>()
    var endSelectedVideos = Array<Photo>()
    
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
                                stop.pointee = true
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
                                stop.pointee = true
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
    
    public func test() {
        Device.iPhone6s_Later()
    }
    
    func fetchPhotosWithResult(result: PHFetchResult<PHAsset>, index: Int, callback: FetchPhotosCallback?) {
        var photos = Array<Photo>()
        var videos = Array<Photo>()
        var objs = Array<Photo>()
        result.enumerateObjects(options: .concurrent) { (asset, idx, stop) in
            var photo = Photo()
            photo.asset = asset
            if self.selectedList.count > 0 {
                var tempSelectedList = self.selectedList
                for (idx ,model) in tempSelectedList.enumerated() {
                    if model.asset?.localIdentifier == photo.asset?.localIdentifier {
                        photo.selected = true
                        if  model.type == .photo ||
                            model.type == .gif   ||
                            model.type == .livePhoto   ||
                            model.type == .cameraPhoto {
                            if model.type == .cameraPhoto {
                                self.selectedCameraPhotos[idx] = photo
                            } else {
                                self.selectedPhotos[idx] = photo
                            }
                        } else {
                            if model.type == .cameraVideo {
                                self.selectedCameraVideos[idx] = photo
                            } else {
                                self.selectedVideos[idx] = photo
                            }
                        }
                        self.selectedList[idx] = photo
                        photo.thumbPhoto = model.thumbPhoto
                        photo.previewPhoto = model.previewPhoto
                        photo.isLiveOhotoOff = model.isLiveOhotoOff
                    }
                }
            }
            if asset.mediaType == .image {
                photo.subType = .photo
                if (asset.value(forKey: "filename") as! String).hasPrefix("GIF") {
                    if self.singleSeleted && self.singleSeleteClip {
                        photo.type = .photo
                    } else {
                        photo.type = self.fetchGifPhoto ? .gif : .photo
                    }
                } else {
                    if Device.iOS_9_1_Later() && Device.iPhone6s_Later() {
                        if asset.mediaSubtypes == .photoLive {
                            if !self.singleSeleted {
                                photo.type = self.fetchLivePhoto ? .livePhoto : .photo
                            } else {
                                photo.type = .photo
                            }
                        } else {
                            photo.type = .photo
                        }
                    } else {
                        photo.type = .photo
                    }
                }
                photos.append(photo)
            } else if asset.mediaType == .video {
                photo.subType = .video
                photo.type = .video
                PHImageManager.default().requestAVAsset(forVideo: asset, options: nil, resultHandler: { (asset, mix, info) in
                    photo.avAssert = asset
                })
                let timeLength = String(format: "%0.0f", asset.duration)
                photo.videoTime = timeLength
                videos.append(photo)
            }
            photo.currentAlbumIndex = index
            objs.append(photo)
        }
        if callback != nil {
            callback!(photos, videos, objs)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
