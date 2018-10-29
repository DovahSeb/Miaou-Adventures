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
import UIKit

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
    //credits to https://icons8.com for providing the icons
    //Declare variables
    var banner = SKShapeNode()
    var scoreLbl = SKLabelNode()
    var score = 0
    var stars1 = SKSpriteNode()
    var stars2 = SKSpriteNode()
    var hero = SKSpriteNode()
    var coins = SKSpriteNode()
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
    var gameOverMap = SKSpriteNode()
    var motionManager = CMMotionManager()
    
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
        
        //banner
        createBanner()
        
        //pause
        createPauseButton()
        
        //restart button
        createRestartButton()
        
        //back button
        createBackButton()
        
        //Score label
        createScoreLabel()
        
        //Fuel capacity
        
        
        //Load stars image
        star1()
        star2()
        
        //Load hero
        addHero()
        
        //Start coins function
        func coinSpawn(){
            let wait = SKAction.wait(forDuration: 10)
            let spawn = SKAction.run(addCoins)
            let sequence = SKAction.sequence([wait, spawn])
            run(SKAction.repeatForever(sequence))
        }; coinSpawn()
        
        //Start meteor function
        func meteorSpawn(){
            let spawn = SKAction.run(addMeteor)
            let wait = SKAction.wait(forDuration: 1.0)
            let sequence = SKAction.sequence([spawn, wait])
            run(SKAction.repeatForever(sequence))
        }; meteorSpawn()
        
    }//init function
    
    override func didMove(to view: SKView) {
        
        //double tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func doubleTapped(_ sender: UITapGestureRecognizer) {
        print("tap")
        if let childCoin = self.childNode(withName: "coin") as? SKSpriteNode {
            run(coinSound)
            createPoints()
            score += 10
            childCoin.removeFromParent()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //Called when a touch starts
        if let touch = touches.first{
            
            if pauseButton.contains(touch.location(in: self)){
                pauseButton.setScale(1.2)
                if self.isPaused == false{
                    self.isPaused = true
                    pauseButton.texture = SKTexture(imageNamed: "play_1")
                } else {
                    self.isPaused = false
                    pauseButton.texture = SKTexture(imageNamed: "pause")
                }
            }
            
            if restartButton.contains(touch.location(in: self)){
                restartButton.setScale(1.2)
                let scene = GamePlayScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
                restartScene()
            }
            
            if backButton.contains(touch.location(in: self)){
                backButton.setScale(1.2)
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if gameOverRestart.contains(touch.location(in: self)){
                gameOverRestart.setScale(1.2)
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
                gameOverQuit.setScale(1.2)
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
            
            if gameOverMap.contains(touch.location(in: self)){
                gameOverMap.setScale(1.2)
                let scene = MapView(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
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
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Called when there's a move touch
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Called when a touch ends
        if let touch = touches.first{
            if pauseButton.contains(touch.location(in: self)){
                pauseButton.setScale(1.0)
            }
            if restartButton.contains(touch.location(in: self)){
                restartButton.setScale(1.0)
            }
            if backButton.contains(touch.location(in: self)){
                backButton.setScale(1.0)
            }
            if gameOverRestart.contains(touch.location(in: self)){
                gameOverRestart.setScale(1.0)
            }
            if gameOverQuit.contains(touch.location(in: self)){
                gameOverQuit.setScale(1.0)
            }
            if gameOverMap.contains(touch.location(in: self)){
                gameOverMap.setScale(1.0)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
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
            stars1.position.y = self.frame.size.height/2
        }
        if stars2.position.y <= -self.frame.size.height {
            stars2.position.y = self.frame.size.height/2
        }
        if let accelerometerData = motionManager.accelerometerData {
            hero.physicsBody!.applyForce(CGVector(dx: 150 * CGFloat(accelerometerData.acceleration.x), dy: 120 * CGFloat(accelerometerData.acceleration.y)))
        }
    }
} //class end
