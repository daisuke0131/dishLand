//
//  EmotionManager.swift
//  dishLand
//
//  Created by 山本　恭大 on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import CoreMotion


enum EMOTIONS {
    //感情
    case normal // 通常時
    case glad //喜
    case anger // 怒
    case sad // 哀
    case happy // 楽
    
    // 話す
    case cheers //かんぱ〜い
    case sadSpeech // 野菜（new!）
    case superSad //かまって
    case goodDrink // 良い飲みっぷりですな！
    case tooDrink // 飲みすぎ!（new!）
}

protocol EmotionManagerDelegate{
    func rawData(x:Double,y:Double,z:Double)
    func changeEmotion(emotion :EMOTIONS)
}

final class EmotionManager: NSObject {
    
    //MARK: API
    var delegate: EmotionManagerDelegate!
    var myMotionManager: CMMotionManager!
    var moveCount = 0
    var emotion : EMOTIONS = EMOTIONS.normal
    static let instance = EmotionManager()
    
    //MARK: private
    private var xCalibrate : Double = 0
    private var yCalibrate : Double = 0
    private var zCalibrate : Double = 0
    
    private var isFirst = true
    
    private let friq = 0.1 // 計測周期
    
    private var counterMilSec = 0.0
    private var counterMilSecBuff = 0.0
    
    private let waitingTime = 50.0
    // 感情変化の時間（5s）
    private let threshold = 0.75
    private let thresholdBig = 1.2
    
    private var xRawData : Double = 0
    
    private var yRawData : Double = 0
    
    private var zRawData : Double = 0
    
    private var finishCalibrate = false;
    
    var drinkCount = 0 //短期間で連続して飲んだ時
    
    private var gladCount = 0 //いい飲みっぷりを言い過ぎない用
    
    private override init() {
        super.init()
        
        analysis()
    }
    
    private func analysis()
    {
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = self.friq
        
        
        let handler:CMAccelerometerHandler = {(data:CMAccelerometerData!, error:NSError!) -> Void in
            
            //キャリブレーションデータ設定
            if(self.finishCalibrate == true)
            {
                self.xCalibrate = data.acceleration.x
                self.yCalibrate = data.acceleration.y
                self.zCalibrate = data.acceleration.z
                self.finishCalibrate = false
            }
            
            self.xRawData = data.acceleration.x - self.xCalibrate
            self.yRawData = data.acceleration.y - self.yCalibrate
            self.zRawData = data.acceleration.z - self.zCalibrate
            
            println("\(self.xRawData)")
            println("\(self.yRawData)")
            println("\(self.zRawData)")
            println("\(self.counterMilSec)")
            
            self.counterMilSec = self.counterMilSec + 1.0
            //===============================================
            
            var isMove = false
            var isBigMove = false
            
            // 動かしたかの判定
            if(abs(self.xRawData) > self.thresholdBig)
            {
                isBigMove = true
            }
            else if(abs(self.yRawData) > self.thresholdBig)
            {
                isBigMove = true
            }
            else if(abs(self.zRawData) > self.thresholdBig)
            {
                isBigMove = true
            }
            else if(abs(self.xRawData) > self.threshold)
            {
                isMove = true
            }
            else if(abs(self.yRawData) > self.threshold)
            {
                isMove = true
            }
            else if(abs(self.zRawData) > self.threshold)
            {
                isMove = true
            }
            
            // 動かした時の処理
            if(isBigMove)
            {
                if(self.isFirst)//初回は乾杯
                {
                    self.delegate.changeEmotion(.cheers)
                    self.delegate.changeEmotion(.happy)
                    self.emotion = .happy
                    self.isFirst = false
                }
                else//次以降は飲んだことに
                {
                    self.drinkCount = self.drinkCount + 1 //連続で飲んでいるのをkaunto
                    if(self.drinkCount > 70)
                    {
                        self.delegate.changeEmotion(.anger)
                        self.delegate.changeEmotion(.tooDrink)
                        self.emotion = .anger
                        self.drinkCount = 0
                        self.counterMilSec = 0
                    }
                    else
                    {
                        if(self.emotion != .anger && self.emotion != .happy)// 怒っている時と乾杯後は、喜には遷移しない
                        {
                            if(self.gladCount > 20)
                            {
                                self.delegate.changeEmotion(.glad)
                                self.delegate.changeEmotion(.goodDrink)
                                self.emotion = .glad
                                self.counterMilSec = 0
                                self.gladCount = 0
                            }
                            self.gladCount = self.gladCount + 1
                        }
                    }
                }
            }
                
            else if(isMove)
            {
                self.moveCount = self.moveCount + 1
                self.counterMilSec = 0 // 動いたらゼロに戻る
            }
            else
            {
                // 動かない時限定の処理
            }
            
            switch(self.emotion)
            {
            case .normal:
                self.normalMove()
                break
            case .anger:
                self.angerMove()
                break
            case .glad:
                self.gladMove()
                break
            case .happy:
                self.happyMove()
                break
            case .sad:
                self.sadMove()
                break
            default:
                self.normalMove()
                break
            }
            self.delegate.rawData(self.xRawData, y: self.yRawData, z: self.zRawData)
            
        }
        
        //取得開始
        myMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:handler)
    }
    
    private func normalMove()
    {
        if(self.counterMilSec > self.waitingTime)
        {
            self.delegate.changeEmotion(.sad)
            self.delegate.changeEmotion(.sadSpeech)
            self.emotion = .sad
            self.counterMilSec = 0
        }
    }
    
    private func angerMove()
    {
        if(self.counterMilSec > self.waitingTime)
        {
            self.delegate.changeEmotion(.normal)
            self.emotion = .normal
            self.counterMilSec = 0
        }
    }
    
    private func sadMove()
    {
        if(self.counterMilSec == 0)
        {
            self.delegate.changeEmotion(.glad)
            self.delegate.changeEmotion(.goodDrink)
            self.emotion = .glad
            self.counterMilSec = 0
        }
        else if(self.counterMilSec % waitingTime == 0)
        {
            self.delegate.changeEmotion(.superSad)
        }
    }
    
    private func gladMove()
    {
        if(self.counterMilSec > self.waitingTime)
        {
            self.delegate.changeEmotion(.normal)
            self.emotion = .normal
            self.counterMilSec = 0
        }
    }
    
    private func happyMove()
    {
        if(self.counterMilSec > self.waitingTime)
        {
            self.delegate.changeEmotion(.normal)
            self.emotion = .normal
            self.counterMilSec = 0
        }
    }
    
    //MARK: API
    func calibrate()
    {
        finishCalibrate = true
        self.delegate.changeEmotion(.normal)
        self.emotion = .normal
        self.counterMilSec = 0
    }
    
    func stop()
    {
        myMotionManager.stopGyroUpdates()
    }
    
    func restart()
    {
        analysis()
    }
}
