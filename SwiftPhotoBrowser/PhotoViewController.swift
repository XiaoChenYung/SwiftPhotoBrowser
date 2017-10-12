//
//  PhotoViewController.swift
//  SwiftPhotoBrowser
//
//  Created by tm on 2017/9/25.
//  Copyright © 2017年 tm. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

public class PhotoViewController: UIViewController, UICollectionViewDelegate {
    
    var manager: PhotoManager
    
    public init(manager: PhotoManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getImages()
        // Do any additional setup after loading the view.
    }
    
    private func getImages() {
        let hud = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballGridPulse, color: UIColor.green, padding: 2)
        self.view.addSubview(hud)
        hud.center = self.view.center
        hud.startAnimating()
        self.manager.fetchAllAlbum(callback: { [unowned self] (albums) in
            self.albums = albums
//            hud.stopAnimating()
//            hud.removeFromSuperview()
        }, showSeletedTag: true)
    }

    /// 初始化UI
    private func setupUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.collectionView)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 内容回调保存
    private lazy var videos = Array<Photo>()
    private lazy var photos = Array<Photo>()
    private lazy var objs = Array<Photo>()
    private lazy var albums = Array<Album>()
    
    /// 图片预览
    private lazy var collectionView: UICollectionView = {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let flowlayout = UICollectionViewFlowLayout()
        let itemWidth = (width - CGFloat(self.manager.rowCount - 1) * (self.manager.spacing)) / CGFloat(self.manager.rowCount)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowlayout.minimumLineSpacing = self.manager.spacing
        flowlayout.minimumInteritemSpacing = self.manager.spacing
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 20, width: width, height: height - 20), collectionViewLayout: flowlayout)
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()

}

extension PhotoViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}
