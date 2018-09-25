//
//  GamePlayScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 20/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
    //Declare bitmasks
    struct CollisionBitMask {
        static let heroCategory:UInt32 = 0x1 << 0
        static let laserCategory:UInt32 = 0x1 << 1
        static let meteorCategory:UInt = 0x1 << 2
    }
    
    //Declare variables
    var scoreLbl = SKLabelNode()
    var score = 0
    var counter = 0
    var stars1 = SKSpriteNode()
    var stars2 = SKSpriteNode()
    var stars3 = SKSpriteNode()
    var scr_vert = SKAction()
    var hero = SKSpriteNode()
    var motionManager = CMMotionManager()
    var meteor = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var playButton = SKSpriteNode()
    var restartButton = SKSpriteNode()
    var backButton = SKSpriteNode()
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      
        
    } // required init
    
    override init(size: CGSize){
        super.init(size: size)
        
        //let viewSize:CGSize!
        //viewSize = size
        
        //Load motionmanager
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        //scene
        createScene()
        
        //pause
        createPauseButton()
        
        //restart button
        createRestartButton()
        
        //back button
        createBackButton()
        
        //Score label
        createScoreLabel()
        
        //Load stars image
        star1()
        
        //stars2 = SKSpriteNode(imageNamed: "stars")
        //stars2.position = CGPoint(x: 0, y: self.frame.size.height)
        //stars2.zPosition = 1
        //self.addChild(stars2)
        
        //stars3 = SKSpriteNode(imageNamed: "stars")
        //stars3.position = CGPoint(x: 0, y: self.frame.size.height + stars2.position.y)
        //stars2.zPosition = 1
        //self.addChild(stars3)
        
        //Start stars scrolling
        stars1.run(scr_vert)
        //stars2.run(scr_vert); stars3.run(scr_vert)
        
        //Load hero
        addHero()
        
        //Load meteor
        addMeteor()
        
        //Start meteor function
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMeteor),
                                                      SKAction.wait(forDuration: 1.0)])))
        
        //score counter
        let delay = SKAction.wait(forDuration: 0.5)
        let incrementScore = SKAction.run ({
            self.score = self.score + 1
            self.scoreLbl.text = "Score: \(self.score)"
        })
        self.run(SKAction.repeatForever(SKAction.sequence([delay,incrementScore])))
        
        
        
    } //init function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //let touch:UITouch = touches.first!
        //let positionInScene = touch.location(in: self)
        //let touchedNode = self.atPoint(positionInScene)
        
        if let touch = touches.first{
            if restartButton.contains(touch.location(in: self)){
                let scene = GamePlayScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "highestScore") != nil {
                    let hscore = defaults.integer(forKey: "highestScore")
                    if hscore < score{
                        defaults.set(score, forKey: "highestScore")
                    }
                } else {
                    defaults.set(0, forKey: "highestScore")
                }
                restartScene()
            }
            
            if backButton.contains(touch.location(in: self)){
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .up, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "highestScore") != nil {
                    let hscore = defaults.integer(forKey: "highestScore")
                    if hscore < score{
                        defaults.set(score, forKey: "highestScore")
                    }
                } else {
                    defaults.set(0, forKey: "highestScore")
                }
            }
        }
        
        if let touch = touches.first{
            if pauseButton.contains(touch.location(in: self)){
                if self.isPaused == false{
                    self.isPaused = true
                    pauseButton.texture = SKTexture(imageNamed: "play_1")
                } else {
                    self.isPaused = false
                    pauseButton.texture = SKTexture(imageNamed: "pause")
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //this ensures that your backgrounds line up perfectly
        if stars1.position.y <= -self.frame.size.height {
            stars1.position.y = self.frame.size.height
        }
        if stars2.position.y <= -self.frame.size.height {
            stars2.position.y = self.frame.size.height
        }
        if stars3.position.y <= -self.frame.size.height {
            stars3.position.y = self.frame.size.height
        }
        if let accelerometerData = motionManager.accelerometerData {
            hero.physicsBody!.applyForce(CGVector(dx: 100 * CGFloat(accelerometerData.acceleration.x), dy: 100 * CGFloat(accelerometerData.acceleration.y)))
        }
    }
} //class end
