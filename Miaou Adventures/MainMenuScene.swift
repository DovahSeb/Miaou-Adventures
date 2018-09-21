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
    
    override func didMove(to view: SKView) {
        
        let viewSize:CGSize = view.bounds.size
        
        //Load background image
        let BG = SKSpriteNode(imageNamed: "BG")
        BG.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        self.addChild(BG)
        
        //Load logo image
        let AppLogo = SKSpriteNode(imageNamed: "applogo_1")
        AppLogo.position = CGPoint(x: viewSize.width/2, y: viewSize.height * 0.7)
        self.addChild(AppLogo)
        
        // Load play button
        let Play = SKSpriteNode(imageNamed: "play")
        Play.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        self.addChild(Play)
        Play.name = "play"
        
        // Load score button
        let Score = SKSpriteNode(imageNamed: "score")
        Score.position = CGPoint(x: viewSize.width/2, y: viewSize.height/3)
        self.addChild(Score)
        Score.name = "score"
        
        // Load credits button
        let Credits = SKSpriteNode(imageNamed: "credits")
        Credits.position = CGPoint(x: viewSize.width/6, y: viewSize.height/10)
        self.addChild(Credits)
        Credits.name = "credits"
        
        // Load sound on&off Button
        soundButton = SKSpriteNode(texture: SoundManager.sharedInstance.isMuted ?soundButtonOff:soundButtonOn)
        soundButton.position = CGPoint(x: viewSize.width/1.2, y: viewSize.height/10)
        addChild(soundButton)
        
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
        }
        
        if let touch = touches.first {
            if selectedButton != nil {
                handleSoundButtonHover(isHovering: false)
            }
            if soundButton.contains(touch.location(in: self)) {
                selectedButton = soundButton
                handleSoundButtonHover(isHovering: true)
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
        if let touch = touches.first {
        if selectedButton == soundButton {
                handleSoundButtonHover(isHovering: (soundButton.contains(touch.location(in: self))))
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
        if let touch = touches.first {
            
         if selectedButton == soundButton {
                handleSoundButtonHover(isHovering: false)
                
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
    
    func handleSoundButtonHover(isHovering : Bool) {
        if isHovering {
            soundButton.alpha = 0.5
        } else {
            soundButton.alpha = 1.0
        }
    }
    
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


