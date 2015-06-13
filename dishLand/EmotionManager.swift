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
    
    var delegate: EmotionManagerDelegate!
    var myMotionManager: CMMotionManager!
    
    private var yRotate:Bool = false
    private var xRotate:Bool = false
    private var zRotate:Bool = false
    
    private override init() {
        super.init()
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = 0.1
        
        let handler:CMAccelerometerHandler = {(data:CMAccelerometerData!, error:NSError!) -> Void in
            println(data.acceleration.x)
            println(data.acceleration.y)
            println(data.acceleration.z)
            
            
            self.delegate.rawData(data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z)
        }
        
        //取得開始
        myMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:handler)
    }
    
    static let instance = EmotionManager()
    
    
}
