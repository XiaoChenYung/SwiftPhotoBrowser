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
        
        test()
        let _v = UIDevice.current.systemVersion
        
        let photoManager = PhotoManager()
        photoManager.test()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test() -> () {
let array = NSArray(array: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20])
array.enumerateObjects(options: .reverse) { (obj, idx, stop) in
    print("内容" + "\(obj)")
    if idx == 3 {
        stop.pointee = true
    }
}
    }
    
}

