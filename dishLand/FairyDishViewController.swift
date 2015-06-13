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
        
        self.manager.delegate = self
        
        self.manager.calibrate()
        
        FairyPlayerManager.playFairyAudio()
        toHappy()
        setBlinkTimer()
        
        
    }
    
    private func setBlinkTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("blink"), userInfo: nil, repeats: true)
    
    }
    
    
    //喜
    private func toGrad(){
        toNormal()
        //after 0.2sec to emotion state
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.emotion = EMOTIONS.glad
            self.rightEye.image = UIImage(named: self.grad["rightEye"]!)
            self.leftEye.image = UIImage(named: self.grad["leftEye"]!)
            self.mouth.image = UIImage(named: self.grad["mouth"]!)
        })
    }
    
    //怒
    private func toAnger(){
        toNormal()
        //after 0.2sec to emotion state
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.emotion = EMOTIONS.anger
            self.rightEye.image = UIImage(named:self.anger["rightEye"]!)
            self.leftEye.image = UIImage(named: self.anger["leftEye"]!)
            self.mouth.image = UIImage(named: self.anger["mouth"]!)
        })

    }

    //哀
    private func toSad(){
        toNormal()
        
        //after 0.2sec to emotion state
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.emotion = EMOTIONS.sad
            self.rightEye.image = UIImage(named: self.sad["rightEye"]!)
            self.leftEye.image = UIImage(named: self.sad["leftEye"]!)
            self.mouth.image = UIImage(named: self.sad["mouth"]!)
        })
    }
    
    //楽
    private func toHappy(){
        toNormal()
        //after 0.2sec to emotion state
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.emotion = EMOTIONS.happy
            self.rightEye.image = UIImage(named: self.happy["rightEye"]!)
            self.leftEye.image = UIImage(named: self.happy["leftEye"]!)
            self.mouth.image = UIImage(named: self.happy["mouth"]!)
        })
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
        emotion = EMOTIONS.normal
        rightEye.image = UIImage(named: normal["rightEye"]!)
        leftEye.image = UIImage(named: normal["leftEye"]!)
        mouth.image = UIImage(named: normal["mouth"]!)
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
            println("normal")
            break
        case .glad:
            self.toGrad()
            println("grad")
            break
        case .anger:
            self.toAnger()
            println("anger")
            break
        case .happy:
            self.toHappy()
            println("happy")
            break
        case .sad:
            self.toSad()
            println("sad")
            break
        case .superSad:
            // かまってー!!
            //prinln("superSad")
            break
        case .cheers:
            // かんぱーい!!
            break
        case .goodDrink:
            // 良い飲みっぷり!!
            break
        default:
            self.toNormal()
            println("normal")
            break
        }
    }
}
