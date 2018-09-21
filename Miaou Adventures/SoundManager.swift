//
//  SoundManager.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 21/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager : NSObject, AVAudioPlayerDelegate {
    let MuteKey = "MIAOU_MUTED"
    static let sharedInstance = SoundManager()
    private(set) var isMuted = false
    
    var audioPlayer : AVAudioPlayer?
    var trackPosition = 0
    
    //Credits
    //Music: https://www.zapsplat.com Royalty free music from zapsplat.com
    static private let tracks = [
        "float_space"]
    
    private override init() {
        //This is private so you can only have one Sound Manager ever.
        trackPosition = Int(arc4random_uniform(UInt32(SoundManager.tracks.count)))
        
        let defaults = UserDefaults.standard
        isMuted = defaults.bool(forKey: MuteKey)
    }
    
    public func startPlaying() {
        if !isMuted && (audioPlayer == nil || audioPlayer?.isPlaying == false) {
            let soundURL = Bundle.main.url(forResource: SoundManager.tracks[trackPosition], withExtension: "mp3")
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                audioPlayer?.delegate = self
            } catch {
                print("audio player failed to load")
                
                startPlaying()
            }
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            trackPosition = (trackPosition + 1) % SoundManager.tracks.count
        } else {
            print("Audio player is already playing!")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //Keep playing
        startPlaying()
    }
    
    func toggleMute() -> Bool {
        isMuted = !isMuted
        
        let defaults = UserDefaults.standard
        defaults.set(isMuted, forKey: MuteKey)
        defaults.synchronize()
        
        if isMuted {
            audioPlayer?.stop()
        } else {
            startPlaying()
        }
        
        return isMuted
    }
    
}
