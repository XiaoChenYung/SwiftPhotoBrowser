//
//  PhotoViewController.swift
//  SwiftPhotoBrowser
//
//  Created by tm on 2017/9/25.
//  Copyright © 2017年 tm. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate {
    
    var manager: PhotoManager
    var collectionView: UICollectionView?
    lazy var videos = Array<Photo>()
    lazy var photos = Array<Photo>()
    lazy var objs = Array<Photo>()
    
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
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: flowlayout)
        self.collectionView?.scrollIndicatorInsets = self.collectionView!.contentInset
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView?.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
}
