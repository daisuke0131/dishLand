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
    case normal // 通常時
    case glad //喜
    case anger // 怒
    case sad // 哀
    case happy // 楽
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
    
    private let friq = 0.1 // 計測周期
    
    private var counterMilSec = 0.0 {
        willSet {
        }
        didSet {
            //counterMilSec = counterMilSec * friq
        }
    }
    
    private let waitingTime = 50.0
    // 感情変化の時間（5s）
    private let threshold = 0.75
    private let thresholdBig = 1.2
    
    private var xRawData : Double = 0{
        willSet {
        }
        didSet {
            xRawData = xRawData - xCalibrate
        }
    }
    
    private var yRawData : Double = 0{
        willSet {
        }
        didSet {
            yRawData = yRawData - yCalibrate
        }
    }
    
    private var zRawData : Double = 0{
        willSet {
        }
        didSet {
            zRawData = zRawData - zCalibrate
        }
    }
    
    private var finishCalibrate = false;
    
    private var yRotate:Bool = false
    private var xRotate:Bool = false
    private var zRotate:Bool = false
    
    //private var let dataMargine =
    
    
    
    private override init() {
        super.init()
        
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = self.friq
        
        
        let handler:CMAccelerometerHandler = {(data:CMAccelerometerData!, error:NSError!) -> Void in
            
            //キャリブレーションデータ設定
            if(self.finishCalibrate == false)
            {
                self.xCalibrate = data.acceleration.x
                self.yCalibrate = data.acceleration.y
                self.zCalibrate = data.acceleration.z
            }
            
            self.xRawData = data.acceleration.x
            self.yRawData = data.acceleration.y
            self.zRawData = data.acceleration.z
            /*
            println("\(self.xRawData)")
            println("\(self.yRawData)")
            println("\(self.zRawData)")
            println("\(self.counterMilSec)")
            */
            self.counterMilSec = self.counterMilSec + 1.0
            //===============================================
            
            var isMove = false
            var isBigMove = false
            
            if(self.counterMilSec > self.waitingTime)
            {
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
            }
            
            if(isBigMove)
            {
                self.delegate.changeEmotion(.happy)
                self.emotion = .happy
                self.counterMilSec = 0
            }
                
            else if(isMove == true)
            {
                self.moveCount = self.moveCount + 1
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
                self.counterMilSec = 0 // 動いたらゼロに戻る
            }
            else
            {
                // 動かない時限定の処理
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
            self.emotion = .sad
            self.counterMilSec = 0
        }
        // 動き続けたらangerへ
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
        self.delegate.changeEmotion(.glad)
        self.emotion = .glad
        self.counterMilSec = 0
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
    }
    
    
}
