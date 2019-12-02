//
//  ViewController.swift
//  catwalk
//
//  Created by student on 2/21/19.
//  Copyright © 2019 Kryptonite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sign: UIButton!
    @IBOutlet weak var log: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sign.layer.cornerRadius=12
        log.layer.cornerRadius=12
        // Do any additional setup after loading the view, typically from a nib.
    }

    
}

