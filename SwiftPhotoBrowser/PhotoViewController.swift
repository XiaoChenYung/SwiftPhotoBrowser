//
//  PhotoViewController.swift
//  SwiftPhotoBrowser
//
//  Created by tm on 2017/9/25.
//  Copyright © 2017年 tm. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var manager: PhotoManager
    var collection: UICollectionView?
    var videos: Array<Photo>?
    var photos: Array<Photo>?
    var objs: Array<Photo>?
    
    public init(manager: PhotoManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    private init() {
        self.manager = PhotoManager()//不会用到
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        let spacing = self.manager.spacing
        let width = self.view.frame.width
        let height = self.view.frame.height
        let flowlayout = UICollectionViewFlowLayout()
        let itemWidth = width - CGFloat((self.manager.rowCount) - 1) * (self.manager.spacing) - 2.0 * (self.manager.margin)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowlayout.minimumLineSpacing = spacing
        flowlayout.minimumInteritemSpacing = spacing
        self.collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: flowlayout)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
