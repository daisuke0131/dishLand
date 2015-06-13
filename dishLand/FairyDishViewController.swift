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
    
    let grad = ["rightEye": "glad_right_eye_00", "leftEye":"glad_left_eye_00","mouth":"glad_mouth_00"]
    let anger = ["rightEye": "anger_right_eye_00", "leftEye":"anger_left_eye_00","mouth":"anger_mouth_00"]
    let sad = ["rightEye": "sad_right_eye_00", "leftEye":"sad_left_eye_00","mouth":"sad_mouth_00"]
    let happy = ["rightEye": "happy_right_eye_00", "leftEye":"happy_left_eye_00","mouth":"happy_mouth_00"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FairyPlayerManager.playFairyAudio()

    }
    
    
    //喜
    private func toGrad(){
        
    }
    
    //怒
    private func toAnger(){
        
    }

    //哀
    private func toSad(){
        
    }
    
    //楽
    private func toHappy(){
        
    }
    
}


extension FairyDishViewController:EmotionManagerDelegate{
    func rawData(x: Double, y: Double, z: Double) {
        
    }
    
    func changeEmotion(emotion: EMOTIONS) {
    }
}
