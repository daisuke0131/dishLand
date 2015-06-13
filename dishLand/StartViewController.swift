//
//  StartViewController.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var delegate:StartViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedStart(sender: AnyObject) {
        delegate?.tappedStart(self)
    }

}

protocol StartViewControllerDelegate{
    func tappedStart(vc:StartViewController)
}
