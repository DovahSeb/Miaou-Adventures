//
//  GameScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 19/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    
    var background = SKSpriteNode()
    var play = SKSpriteNode()
    var score = SKSpriteNode()
    var howto = SKSpriteNode()
    
    let soundButtonOn = SKTexture(imageNamed: "sound_on")
    let soundButtonOff = SKTexture(imageNamed: "sound_off")
    
    var soundButton : SKSpriteNode! = nil
    var selectedButton : SKSpriteNode?
    
    var resetScore = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        let viewSize:CGSize = view.bounds.size
        
        //Load background
        background = SKSpriteNode(imageNamed: "BG")
        background.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        background.zPosition = 1
        self.addChild(background)
        
        //Load logo image
        let appLogo = SKSpriteNode(imageNamed: "applogo_1")
        appLogo.position = CGPoint(x: viewSize.width/2, y: viewSize.height * 0.75)
        appLogo.zPosition = 2
        self.addChild(appLogo)
        
        // Load play button
        play = SKSpriteNode(imageNamed: "play")
        play.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        play.zPosition = 2
        self.addChild(play)
        //play.name = "play"
        
        // Load score button
        score = SKSpriteNode(imageNamed: "score")
        score.position = CGPoint(x: viewSize.width/2, y: viewSize.height/3)
        score.zPosition = 2
        self.addChild(score)
        //score.name = "score"
        
        // Load howto button
        howto = SKSpriteNode(imageNamed: "howto")
        howto.position = CGPoint( x: viewSize.width/1.2, y: viewSize.height/10)
        howto.zPosition = 2
        self.addChild(howto)
        
        // Load sound on&off Button
        soundButton = SKSpriteNode(texture: SoundManager.sharedInstance.isMuted ?soundButtonOff:soundButtonOn)
        soundButton.position = CGPoint(x: viewSize.width/6, y: viewSize.height/10)
        soundButton.zPosition = 2
        addChild(soundButton)
        
    }
    
    override func sceneDidLoad() {
        //Reset Score
        createResetScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if let touch = touches.first {
            
            if play.contains(touch.location(in: self)){
                play.setScale(1.2)
                let scene = GamePlayScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if score.contains(touch.location(in: self)){
                score.setScale(1.2)
                let scene = ScoreScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if howto.contains(touch.location(in: self)){
                howto.setScale(1.2)
                let scene = HowToScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if selectedButton != nil {
            }
            if soundButton.contains(touch.location(in: self)) {
                selectedButton = soundButton
            }
            
            if resetScore.contains(touch.location(in: self)){
                resetScore.setScale(1.1)
                let defaults = UserDefaults.standard
                defaults.set(0, forKey: "highestScore")
                defaults.synchronize()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*Called when a touch ends*/
        if let touch = touches.first {
            if play.contains(touch.location(in: self)){
                play.setScale(1)
            }
            
            if score.contains(touch.location(in: self)){
                score.setScale(1)
            }
            
            if howto.contains(touch.location(in: self)){
                howto.setScale(1)
            }
            
            if resetScore.contains(touch.location(in: self)){
                resetScore.setScale(1)
            }
            
            if selectedButton == soundButton {
                if (soundButton.contains(touch.location(in: self))) {
                    handleSoundButtonClick()
                }
            }
        }
        selectedButton = nil
    }
    
    //Handles button click
    func handleSoundButtonClick() {
        if SoundManager.sharedInstance.toggleMute() {
            //Is muted
            soundButton.texture = soundButtonOff
        } else {
            //Is not muted
            soundButton.texture = soundButtonOn
        }
    }
}


