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
    
    
    var emotion:EMOTIONS = EMOTIONS.glad
    
    let grad = ["rightEye": "glad_right_eye", "leftEye":"glad_left_eye","mouth":"glad_mouth"]
    let anger = ["rightEye": "anger_right_eye", "leftEye":"anger_left_eye","mouth":"anger_mouth"]
    let sad = ["rightEye": "sad_right_eye", "leftEye":"sad_left_eye","mouth":"sad_mouth"]
    let happy = ["rightEye": "happy_right_eye", "leftEye":"happy_left_eye","mouth":"happy_mouth"]
    let normal = ["rightEye": "blink_right_eye", "leftEye":"blink_left_eye","mouth":"close_mouth"]
    
    let blinkEyes = ["rightEye":"blink_right_eye","leftEye":"blink_left_eye"]
    private var manager : EmotionManager! = EmotionManager.instance
    
    var timer:NSTimer?
    
    deinit{
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.manager.delegate = self
        
//        self.manager.calibrate()
        
//        FairyPlayerManager.playFairyAudio()
        toAnger()
        setBlinkTimer()
        
        
    }
    
    private func setBlinkTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("blink"), userInfo: nil, repeats: true)
    
    }
    
    
    //喜
    private func toGrad(){
        emotion = EMOTIONS.glad
        rightEye.image = UIImage(named: grad["rightEye"]!)
        leftEye.image = UIImage(named: grad["leftEye"]!)
        mouth.image = UIImage(named: grad["mouth"]!)
    }
    
    //怒
    private func toAnger(){
        emotion = EMOTIONS.anger
        rightEye.image = UIImage(named: anger["rightEye"]!)
        leftEye.image = UIImage(named: anger["leftEye"]!)
        mouth.image = UIImage(named: anger["mouth"]!)
    }

    //哀
    private func toSad(){
        emotion = EMOTIONS.sad
        rightEye.image = UIImage(named: sad["rightEye"]!)
        leftEye.image = UIImage(named: sad["leftEye"]!)
        mouth.image = UIImage(named: sad["mouth"]!)
    }
    
    //楽
    private func toHappy(){
        emotion = EMOTIONS.happy
        rightEye.image = UIImage(named: happy["rightEye"]!)
        leftEye.image = UIImage(named: happy["leftEye"]!)
        mouth.image = UIImage(named: happy["mouth"]!)
    }
    
    //to blink mode
    func blink(){
        rightEye.image = UIImage(named: blinkEyes["rightEye"]!)
        leftEye.image = UIImage(named: blinkEyes["leftEye"]!)

        //after 0.2sec to emotion state
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.changeEmotion(self.emotion)
        })
    }
    
    // 通常
    private func toNormal()
    {
        
    }
    
    // タイマー走らせて
    private func speaking(){
        
    }
    
}


extension FairyDishViewController:EmotionManagerDelegate{
    func rawData(x: Double, y: Double, z: Double) {
        
    }
    
    func changeEmotion(emotion: EMOTIONS) {
        switch(emotion)
        {
        case .normal:
            self.toNormal()
            break
        case .glad:
            self.toGrad()
            break
        case .anger:
            self.toAnger()
            break
        case .happy:
            self.toHappy()
            break
        case .sad:
            self.toSad()
            break
        default:
            self.toNormal()
            break
        }
    }
}
