//
//  FairyPlayerManager.swift
//  dishLand
//
//  Created by daisuke on 2015/06/13.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import AVFoundation

class FairyPlayer: NSObject,AVAudioPlayerDelegate {
    
    var delegate:FairyPlayerDelegate?
    
    var player: AVAudioPlayer?
    
    override init() {
        super.init()
    }
    
//    class func playKanpai(){
//        sharedInstance.playKanpai()
//    }
//    
//    class func playShouldEatVegetables(){
//        sharedInstance.playShouldEatVegetables()
//    }
//    
//    class func playPleaseWatchPhoto(){
//        sharedInstance.playPleaseWatchPhoto()
//    }
//    
//    class func playPleaseKamatte(){
//        sharedInstance.playPleaseKamatte()
//    }
//    
//    class func playGoodDrink(){
//        sharedInstance.playGoodDrink()
//    }
//    
//    class func playDrinkHighPace(){
//        sharedInstance.playDrinkHighPace()
//    }
    
    func playKanpai(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("1-kanpai", ofType: "wav")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
            player = p
            player!.delegate = self
            player!.play()
        }
    }
    
    func playShouldEatVegetables(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("2-yasai_tabete", ofType: "wav")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
            player = p
            player!.delegate = self
            player!.play()
        }
        
    }
    func playPleaseWatchPhoto(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("3-a-syasin_mite", ofType: "wav")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
            player = p
            player!.delegate = self
            player!.play()
        }
        
    }
    func playPleaseKamatte(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("4-b-kamatte", ofType: "wav")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
        player = p
        player!.delegate = self
        player!.play()
        }
    }
    
     func playGoodDrink(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("5-nomippuri", ofType: "wav")!)
        
        if let p = AVAudioPlayer(contentsOfURL: audioPath, error: nil){
            player = p
            player!.delegate = self
            player!.play()
        }
        
    }
    
    func playDrinkHighPace(){
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("6-peesu_hayai", ofType: "wav")!)
        
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
        delegate?.endSpeaking(self)
    }
}

protocol FairyPlayerDelegate{
    func endSpeaking(player:FairyPlayer)
}
