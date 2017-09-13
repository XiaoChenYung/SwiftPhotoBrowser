//
//  Photo.swift
//  SwiftPhotoBrowserDemo
//
//  Created by tm on 2017/9/13.
//  Copyright © 2017年 tm. All rights reserved.
//

import Foundation
import Photos

enum MediaType {
    case Photo
    case LivePhoto
    case Gif
    case Video
    case Audio
    case CameraPhoto
    case CameraVideo
    case Camera
}

enum MediaSubType {
    case Photo
    case Video
}

public class Photo {
    var asset: PHAsset?
    var identifier: String?
    var orginalURL: NSURL?
    var avAssert: AVAsset?
    var playerItem: AVPlayerItem?
    var type: MediaType?
    var subType: MediaSubType?
    var thumbPhoto: UIImage?
    var previewPhoto: UIImage?
    var albumName: String?
    var requestID: PHImageRequestID?
    var liveRequestID: PHImageRequestID?
    var videoTime: String?
    var selIndex: Int = 0
    var selected: Bool = false
    var imageSize: CGSize = CGSize(width: 0, height: 0)
    var endImageSize: CGSize = CGSize(width: 0, height: 0)
    var isLiveOhotoOff: Bool = false
    var cameraIdentifier: String?
    var videoURL: URL?
    var netPhotoURL: String?
    var currentAlbumIndex: Int = 0
    var endIndex: Int = 0
    var videoIndex: Int = 0
    var endCollectionIndex: Int = 0
    var fetchOrginalIndex: Int = 0
    var fetchImageDataIndex: Int = 0
    var receivedSize: Int = 0
    var expectedSize: Int = 0
    var downloadCompleted: Bool = false
    var downloadError: Bool = false
    var tempImage: UIImage?
    var rawCount: Int = 0
    var requestSize: CGSize = CGSize(width: 0, height: 0)
    
    func prefetchThumbImage() {
        
    }
    
    func cancleImageRequest() {
        
    }
    
}
