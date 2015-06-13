//
//  FairyPlayerManager.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import AVFoundation

class FairyPlayerManager: NSObject,AVAudioPlayerDelegate {
   
    static var sharedInstance = FairyPlayerManager()
    var player: AVAudioPlayer?
    
    override init() {
        super.init()
    }
    
    class func playFairyAudio(){
        sharedInstance.playFairyAudio()

    }
    
    private func playFairyAudio(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("kanpai", ofType: "wav")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
            player = p
            player!.delegate = self
            player!.play()
        }
    }
    
    func playOrPause() {
        if let player = player{
            if (player.playing) {
                player.pause()
            } else {
                player.play()
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        player.stop()
    }
    
    
    
}
