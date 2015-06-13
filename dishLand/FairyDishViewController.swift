//
//  FairyDishViewController.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class FairyDishViewController: UIViewController {
    
    
    @IBOutlet weak var rightEye: UIImageView!
    
    @IBOutlet weak var leftEye: UIImageView!
    
    @IBOutlet weak var mouth: UIImageView!
    
    let grad = ["rightEye": "glad_right_eye", "leftEye":"glad_left_eye","mouth":"glad_mouth"]
    let anger = ["rightEye": "anger_right_eye", "leftEye":"anger_left_eye","mouth":"anger_mouth"]
    let sad = ["rightEye": "sad_right_eye", "leftEye":"sad_left_eye","mouth":"sad_mouth"]
    let happy = ["rightEye": "happy_right_eye", "leftEye":"happy_left_eye","mouth":"happy_mouth"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FairyPlayerManager.playFairyAudio()
        toAnger()
    }
    
    
    //喜
    private func toGrad(){
        rightEye.image = UIImage(named: grad["rightEye"]!)
        leftEye.image = UIImage(named: grad["leftEye"]!)
        mouth.image = UIImage(named: grad["mouth"]!)
    }
    
    //怒
    private func toAnger(){
        rightEye.image = UIImage(named: anger["rightEye"]!)
        leftEye.image = UIImage(named: anger["leftEye"]!)
        mouth.image = UIImage(named: anger["mouth"]!)
    }

    //哀
    private func toSad(){
        rightEye.image = UIImage(named: sad["rightEye"]!)
        leftEye.image = UIImage(named: sad["leftEye"]!)
        mouth.image = UIImage(named: sad["mouth"]!)
    }
    
    //楽
    private func toHappy(){
        rightEye.image = UIImage(named: happy["rightEye"]!)
        leftEye.image = UIImage(named: happy["leftEye"]!)
        mouth.image = UIImage(named: happy["mouth"]!)
    }
    
}


extension FairyDishViewController:EmotionManagerDelegate{
    func rawData(x: Double, y: Double, z: Double) {
        
    }
    
    func changeEmotion(emotion: EMOTIONS) {
    }
}
