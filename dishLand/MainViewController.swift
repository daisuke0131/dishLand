//
//  ViewController.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit


enum FairyKind:Int{
    case start  = 0
    case fairy1 = 1
    case fairy2 = 2
}


class MainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
    var fairyVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        changeFairyView(FairyKind.start)
    }

    
    //お皿さんの顔を切り替える場合はこれを呼び出す
    private func changeFairyView(fairy:FairyKind){
        if let fairyVC = fairyVC{
            fairyVC.view.removeFromSuperview()
        }
        
        switch fairy{
        case FairyKind.start:
            fairyVC = storyboard!.instantiateViewControllerWithIdentifier("start") as? StartViewController
            (fairyVC as! StartViewController).delegate = self
            self.addChildViewController(fairyVC!)
            fairyVC!.didMoveToParentViewController(self)
            fairyVC!.view.frame = view.frame
            containerView.addSubview(fairyVC!.view)
        case FairyKind.fairy1:
            fairyVC = storyboard!.instantiateViewControllerWithIdentifier("fairy") as? FairyDishViewController
            navigationController?.pushViewController(fairyVC!, animated: true)
        case FairyKind.fairy2:
            break;
        }
        
        

    }


}

extension MainViewController:StartViewControllerDelegate{
    func tappedStart(vc: StartViewController) {
        changeFairyView(FairyKind.fairy1)
    }
}

