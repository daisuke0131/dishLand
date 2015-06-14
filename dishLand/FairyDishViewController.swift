//
//  FairyDishViewController.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class FairyDishViewController: UIViewController {
    
    var delegate:FairyDishExecuteEndDelegate?
    
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
    let talkingMouth = ["mouth":"talking_mouth"]
    private var manager : EmotionManager? = EmotionManager.instance
    
    var blinkTimer:NSTimer?
    var speakingTimer:NSTimer?
    var mouthClosed:Bool = false
    var isSpeaking:Bool = false
    
    var players:[FairyPlayer] = [FairyPlayer]()
    
    deinit{
        blinkTimer?.invalidate()
        speakingTimer?.invalidate()
        manager = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager?.delegate = self
        self.manager?.calibrate()
        
        startBlink()
        
        self.goodDrink()
        self.goodDrink()
//        self.goodDrink()
//        self.goodDrink()
//        self.goodDrink()
//        self.goodDrink()
    }
    
    
    private func playKanpai(){
        startSpeaking()
        let player =  FairyPlayer()
        player.delegate = self
        player.playKanpai()
        players.append(player)
        sleep(1)
        var camera: SecretCamera = SecretCamera()
        camera.openTake()
    }
    private func shouldEatVegetables(){
        startSpeaking()
        let player =  FairyPlayer()
        player.delegate = self
        player.playShouldEatVegetables()
        players.append(player)
    }
    private func pleaseWatchPhoto(){
        startSpeaking()
        let player =  FairyPlayer()
        player.delegate = self
        player.playPleaseWatchPhoto()
        players.append(player)
    }
    private func pleaseKamatte(){
        startSpeaking()
        let player =  FairyPlayer()
        player.delegate = self
        player.playPleaseKamatte()
        players.append(player)
    }
    
    private func goodDrink(){
        startSpeaking()
        let player =  FairyPlayer()
        player.delegate = self
        player.playGoodDrink()
        players.append(player)
    }
    
    private func drinkHighPace(){
        startSpeaking()
        let player =  FairyPlayer()
        player.delegate = self
        player.playDrinkHighPace()
        players.append(player)
    }
    
    //ノーマルの感情表現切り替え
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
    
    // 通常
    private func toNormal()
    {
        emotion = EMOTIONS.normal
        rightEye.image = UIImage(named: normal["rightEye"]!)
        leftEye.image = UIImage(named: normal["leftEye"]!)
        mouth.image = UIImage(named: normal["mouth"]!)
    }
    

    //for Eye
    private func startBlink(){
        blinkTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("blink"), userInfo: nil, repeats: true)
    }
    
    //to blink mode
    func blink(){
        rightEye.image = UIImage(named: blinkEyes["rightEye"]!)
        leftEye.image = UIImage(named: blinkEyes["leftEye"]!)
        
        //after 0.2sec to emotion state
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.changeEmotionEye(self.emotion)
        })
    }
    
    //for Eye
    //目だけ感情表現を戻す。
    private func changeEmotionEye(emotion: EMOTIONS){
        switch(emotion)
        {
        case .normal:
            self.toNormalEye()
            break
        case .glad:
            self.toGradEye()
            break
        case .anger:
            self.toAngerEye()
            break
        case .happy:
            self.toHappyEye()
            break
        case .sad:
            self.toSadEye()
            break
        default:
            self.toNormalEye()
            break
        }
    }
    
    
    //喜
    private func toGradEye(){
        emotion = EMOTIONS.glad
        rightEye.image = UIImage(named: grad["rightEye"]!)
        leftEye.image = UIImage(named: grad["leftEye"]!)
    }
    
    //怒
    private func toAngerEye(){
        emotion = EMOTIONS.anger
        rightEye.image = UIImage(named:anger["rightEye"]!)
        leftEye.image = UIImage(named: anger["leftEye"]!)
    }
    
    //哀
    private func toSadEye(){
        emotion = EMOTIONS.sad
        rightEye.image = UIImage(named: sad["rightEye"]!)
        leftEye.image = UIImage(named: sad["leftEye"]!)
    }
    
    //楽
    private func toHappyEye(){
        emotion = EMOTIONS.happy
        rightEye.image = UIImage(named: happy["rightEye"]!)
        leftEye.image = UIImage(named: happy["leftEye"]!)
        
    }
    
    // 通常
    private func toNormalEye()
    {
        emotion = EMOTIONS.normal
        rightEye.image = UIImage(named: normal["rightEye"]!)
        leftEye.image = UIImage(named: normal["leftEye"]!)
    }
    
    //for Mouth
    
    //口だけ感情表現を戻す。
    private func changeEmotionMouth(emotion: EMOTIONS){
        switch(emotion)
        {
        case .normal:
            self.toNormalMouth()
            break
        case .glad:
            self.toGradMouth()
            break
        case .anger:
            self.toAngerMouth()
            break
        case .happy:
            self.toHappyMouth()
            break
        case .sad:
            self.toSadMouth()
            break
        default:
            self.toNormalMouth()
            break
        }
    }
    
    //喜
    private func toGradMouth(){
        emotion = EMOTIONS.glad
        mouth.image = UIImage(named: grad["mouth"]!)
    }
    
    //怒
    private func toAngerMouth(){
        emotion = EMOTIONS.anger
        mouth.image = UIImage(named:anger["mouth"]!)
    }
    
    //哀
    private func toSadMouth(){
        emotion = EMOTIONS.sad
        mouth.image = UIImage(named: sad["mouth"]!)
    }
    
    //楽
    private func toHappyMouth(){
        emotion = EMOTIONS.happy
        mouth.image = UIImage(named: happy["mouth"]!)
    }
    
    // 通常
    private func toNormalMouth()
    {
        emotion = EMOTIONS.normal
        mouth.image = UIImage(named: normal["mouth"]!)
    }
    
    // タイマー走らせて口パクパク
    private func startSpeaking(){
        
        if !isSpeaking{
            speakingTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("speaking"), userInfo: nil, repeats: true)
            
            // 最初は口を開ける
            mouth.image = UIImage(named: talkingMouth["mouth"]!)
            mouthClosed = false
            isSpeaking = true
        }
    }
    
    //to speaking mode
    func speaking(){
        //after 0.2sec to emotion state
        changeSpeakingMouth()
    }
    
    //口パクパクを終了
    private func stopSpeaking(player:FairyPlayer){
        speakingTimer?.invalidate()
        changeEmotion(self.emotion)
        isSpeaking = false
        for(var i = 0; i < players.count ; i++){
            if players[i] == player{
                players.removeAtIndex(i)
            }
        }
    }
    
    private func changeSpeakingMouth(){
        if mouthClosed{
            // open mouth
            mouth.image = UIImage(named: talkingMouth["mouth"]!)
            mouthClosed = false
        }else{
            mouth.image = UIImage(named: normal["mouth"]!)
            mouthClosed = true
        }
    }
    
    
    @IBAction func tappedEnd(sender: AnyObject) {
        self.delegate?.tappedEnd(self)
    }
    
    
    
}

protocol FairyDishExecuteEndDelegate{
    func tappedEnd(vc:UIViewController)
}

extension FairyDishViewController:FairyPlayerDelegate{
    func endSpeaking(player:FairyPlayer) {
        stopSpeaking(player)
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
        case .glad:
            self.toGrad()
        case .anger:
            self.toAnger()
        case .happy:
            self.toHappy()
        case .sad:
            self.toSad()
        case .superSad:
            self.pleaseKamatte()
        case .cheers:
            self.playKanpai()
        case .goodDrink:
            self.goodDrink()
        case .tooDrink:
            self.drinkHighPace()
        case .sadSpeech:
            self.shouldEatVegetables()
        }
    }
}
