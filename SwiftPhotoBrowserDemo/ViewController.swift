//
//  ViewController.swift
//  SwiftPhotoBrowserDemo
//
//  Created by tm on 2017/9/13.
//  Copyright © 2017年 tm. All rights reserved.
//

import UIKit
import SwiftPhotoBrowser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let photoManager = PhotoManager()       
        let photoViewController = PhotoViewController(manager: photoManager)
        self.addChildViewController(photoViewController)
        photoViewController.view.frame = self.view.bounds
        self.view.addSubview(photoViewController.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test() -> () {

    }
    
}

