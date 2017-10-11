//
//  PhotoViewController.swift
//  SwiftPhotoBrowser
//
//  Created by tm on 2017/9/25.
//  Copyright © 2017年 tm. All rights reserved.
//

import UIKit

public class PhotoViewController: UIViewController, UICollectionViewDelegate {
    
    var manager: PhotoManager
    var collectionView: UICollectionView?
    lazy var videos = Array<Photo>()
    lazy var photos = Array<Photo>()
    lazy var objs = Array<Photo>()
    
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
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        let spacing = self.manager.spacing
        let width = self.view.frame.width
        let height = self.view.frame.height
        let flowlayout = UICollectionViewFlowLayout()
        let itemWidth = (width - CGFloat(self.manager.rowCount - 1) * (self.manager.spacing) - 2.0 * self.manager.margin) / CGFloat(self.manager.rowCount)
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
        self.collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.collectionView!)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
