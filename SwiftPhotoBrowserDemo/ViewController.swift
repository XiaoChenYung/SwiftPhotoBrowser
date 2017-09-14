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
    
    let manager = PhotoManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        manager.fetchAllAlbum { (array) in
            print(array)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

