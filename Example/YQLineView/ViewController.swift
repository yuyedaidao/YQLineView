//
//  ViewController.swift
//  YQLineView
//
//  Created by wyqpadding@gmail.com on 05/14/2019.
//  Copyright (c) 2019 wyqpadding@gmail.com. All rights reserved.
//

import UIKit
import YQLineView

class ViewController: UIViewController {
    @IBOutlet weak var lineView: YQLineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lineView.positions = [.left, .bottom, .right, .top]
        lineView.edgeInsets = UIEdgeInsets(top: 10, left: 6, bottom: 8, right: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

