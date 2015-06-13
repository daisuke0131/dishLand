//
//  ViewController.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit


enum FairyKind:Int{
    case fairy1 = 0
    case fairy2 = 1
}


class MainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
    var fairyVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeFairyView(FairyKind.fairy1)
    }

    
    //お皿さんの顔を切り替える場合はこれを呼び出す
    private func changeFairyView(fairy:FairyKind){
        if let fairyVC = fairyVC{
            fairyVC.view.removeFromSuperview()
        }
        
        switch fairy{
        case FairyKind.fairy1:
            fairyVC = storyboard!.instantiateViewControllerWithIdentifier("fairy") as! FairyDishViewController
            self.addChildViewController(fairyVC!)
            fairyVC!.didMoveToParentViewController(self)
            fairyVC!.view.frame = view.frame
            containerView.addSubview(fairyVC!.view)
        case FairyKind.fairy2:
            break;
        }
        
        

    }


}

