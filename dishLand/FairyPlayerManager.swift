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
   
    var player: AVAudioPlayer?
    
    override init() {
        super.init()
        

    }
    
    func playFairyAudio(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("fairyAudio", ofType: "mp3")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
            player = p
            player!.delegate = self
            player!.prepareToPlay()
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
