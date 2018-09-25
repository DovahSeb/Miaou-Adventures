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
    
    let soundButtonOn = SKTexture(imageNamed: "sound_on")
    let soundButtonOff = SKTexture(imageNamed: "sound_off")
    
    var soundButton : SKSpriteNode! = nil
    var selectedButton : SKSpriteNode?
    
    var resetScore = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        let viewSize:CGSize = view.bounds.size
        
        //Load background image
        let bg = SKSpriteNode(imageNamed: "BG")
        bg.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        bg.zPosition = 1
        self.addChild(bg)
        
        //Load logo image
        let appLogo = SKSpriteNode(imageNamed: "applogo_1")
        appLogo.position = CGPoint(x: viewSize.width/2, y: viewSize.height * 0.7)
        appLogo.zPosition = 2
        self.addChild(appLogo)
        
        // Load play button
        let play = SKSpriteNode(imageNamed: "play")
        play.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        play.zPosition = 2
        self.addChild(play)
        play.name = "play"
        
        // Load score button
        let score = SKSpriteNode(imageNamed: "score")
        score.position = CGPoint(x: viewSize.width/2, y: viewSize.height/3)
        score.zPosition = 2
        self.addChild(score)
        score.name = "score"
        
        // Load credits button
        let credits = SKSpriteNode(imageNamed: "credits")
        credits.position = CGPoint(x: viewSize.width/6, y: viewSize.height/10)
        credits.zPosition = 2
        self.addChild(credits)
        credits.name = "credits"
        
        // Load sound on&off Button
        soundButton = SKSpriteNode(texture: SoundManager.sharedInstance.isMuted ?soundButtonOff:soundButtonOn)
        soundButton.position = CGPoint(x: viewSize.width/1.2, y: viewSize.height/10)
        soundButton.zPosition = 2
        addChild(soundButton)
        
        //Reset Score
        createResetScore()
        
    }
    
    
    override func sceneDidLoad() {

        
    }
    
    func touchBegan(toPoint pos : CGPoint){
        
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "play"{
            let scene = GamePlayScene(size: self.size)
            let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if name == "credits"{
                let scene = CreditsScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if name == "score"{
                let scene = ScoreScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
        
        if let touch = touches.first {
            if selectedButton != nil {
            }
            if soundButton.contains(touch.location(in: self)) {
                selectedButton = soundButton
            }
        }
        if let touch = touches.first{
            if resetScore.contains(touch.location(in: self)){
                let defaults = UserDefaults.standard
                defaults.set(0, forKey: "highestScore")
                defaults.synchronize()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
        if let touch = touches.first {
         if selectedButton == soundButton {
                if (soundButton.contains(touch.location(in: self))) {
                    handleSoundButtonClick()
                }
            }
        }
        selectedButton = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
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


