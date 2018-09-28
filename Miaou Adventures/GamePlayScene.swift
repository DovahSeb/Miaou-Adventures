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
    
    //Declare variables
    var scoreLbl = SKLabelNode()
    var score = 0
    var stars1 = SKSpriteNode()
    var stars2 = SKSpriteNode()
    var hero = SKSpriteNode()
    var coins = SKSpriteNode()
    var motionManager = CMMotionManager()
    var meteor = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var playButton = SKSpriteNode()
    var restartButton = SKSpriteNode()
    var backButton = SKSpriteNode()
    var Points = SKSpriteNode()
    var Explosion = SKSpriteNode()
    var gameOverText = SKLabelNode()
    var gameOverScore = SKLabelNode()
    var gameOverRestart = SKSpriteNode()
    var gameOverQuit = SKSpriteNode()
    
    //Sounds
    //Credits to: https://www.zapsplat.com for providing the sound effects
    let coinSound = SKAction.playSoundFileNamed("coin.mp3", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      
        
    } // required init
    
    override init(size: CGSize){
        super.init(size: size)
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
        star2()
        
        //Load hero
        addHero()
        
        //Start coins function
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addCoins), SKAction.wait(forDuration: 20.0)])))
        
        //Start meteor function
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMeteor),
                                                      SKAction.wait(forDuration: 1.0)])))
        
    } //init function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if let touch = touches.first{
            if restartButton.contains(touch.location(in: self)){
                let scene = GamePlayScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
                restartScene()
            }
            
            if backButton.contains(touch.location(in: self)){
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if gameOverRestart.contains(touch.location(in: self)){
                let scene = GamePlayScene(size: self.size)
                self.view?.presentScene(scene)
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
            
            if gameOverQuit.contains(touch.location(in: self)){
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition:reveal)
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.heroCategory && secondBody.categoryBitMask == CollisionBitMask.coinsCategory{
            print("contact")
            run(coinSound)
            contact.bodyB.node?.removeFromParent()
            createPoints()
            score += 10
        }
        
        if firstBody.categoryBitMask == CollisionBitMask.heroCategory && secondBody.categoryBitMask == CollisionBitMask.meteorCategory{
            print("contact")
            run(explosionSound)
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            createExplosion()
            gameOver()
            
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
        if let accelerometerData = motionManager.accelerometerData {
            hero.physicsBody!.applyForce(CGVector(dx: 120 * CGFloat(accelerometerData.acceleration.x), dy: 120 * CGFloat(accelerometerData.acceleration.y)))
        }
    }
} //class end
