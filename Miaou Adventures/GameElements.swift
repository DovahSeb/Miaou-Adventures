//
//  GameElements.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 25/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


//Credits to: https://icons8.com for provinding the icons

//Declare bitmasks
struct CollisionBitMask {
    static let heroCategory:UInt32 = 0x1 << 0
    static let coinsCategory:UInt32 = 0x1 << 1
    static let meteorCategory:UInt32 = 0x1 << 2
    static let sceneCategory: UInt32 = 0x1 << 3
    static let bannerCategory: UInt32 = 0x1 << 4
}

extension GamePlayScene{
    
    func createBanner(){
        let bannerSize = CGSize(width: frame.size.width, height: frame.size.height/9.5)
        banner = SKShapeNode(rectOf: bannerSize)
        banner.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.95)
        banner.zPosition = 3
        banner.physicsBody = SKPhysicsBody(rectangleOf: bannerSize)
        banner.physicsBody?.isDynamic = false
        banner.physicsBody?.affectedByGravity = false
        banner.physicsBody?.categoryBitMask = CollisionBitMask.bannerCategory
        banner.physicsBody?.collisionBitMask = CollisionBitMask.heroCategory
        banner.physicsBody?.contactTestBitMask = CollisionBitMask.heroCategory
        banner.fillColor = UIColor(red:87/255, green:182/255, blue:170/255, alpha: 1)
        self.addChild(banner)
    }
    
    func createPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.position = CGPoint(x: self.frame.width * 0.8, y: self.frame.height * 0.94)
        pauseButton.zPosition = 4
        self.addChild(pauseButton)
    }
    
    func createRestartButton(){
        restartButton = SKSpriteNode(imageNamed: "reset")
        restartButton.position = CGPoint(x: self.frame.width * 0.9, y: self.frame.height * 0.94)
        restartButton.zPosition = 4
        self.addChild(restartButton)
    }
    
    func createBackButton(){
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.94)
        backButton.zPosition = 4
        self.addChild(backButton)
    }
    
    func createScoreLabel(){
        scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.92)
        scoreLbl.text = "Score: 0"
        scoreLbl.fontColor = SKColor.white
        scoreLbl.zPosition = 4
        scoreLbl.fontSize = 20
        scoreLbl.fontName = "Verdana"
        self.addChild(scoreLbl)
        let delay = SKAction.wait(forDuration: 0.5)
        let incrementScore = SKAction.run ({
            self.score += 1
            self.scoreLbl.text = "Score: " + "\(self.score)"
        })
        scoreLbl.run(SKAction.repeatForever(SKAction.sequence([delay,incrementScore])))
    }
    
    
    func star1(){
        stars1 = SKSpriteNode(imageNamed: "stars")
        stars1.position = CGPoint(x: self.size.width, y: self.size.height)
        stars1.zPosition = 1
        let scrollDown = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height), duration: 4))
        stars1.run(scrollDown)
        self.addChild(stars1)
    }
    
    func star2(){
        stars2 = SKSpriteNode(imageNamed: "stars")
        stars2.position = CGPoint(x: 0, y: stars1.size.height - 1)
        stars2.zPosition = 1
        let scrollDown = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height), duration: 4))
        stars2.run(scrollDown)
        self.addChild(stars2)
    }
    
    func addHero(){
        hero = SKSpriteNode(imageNamed: "cat_hero")
        hero.position = CGPoint(x: self.frame.width/2, y: self.frame.height/10)
        hero.zPosition = 2
        //Add physics
        hero.physicsBody = SKPhysicsBody(circleOfRadius: max(hero.size.width/2, hero.size.height/2))
        hero.physicsBody?.usesPreciseCollisionDetection = true
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.affectedByGravity = false
        hero.physicsBody?.mass = 0.10
        hero.physicsBody?.allowsRotation = false
        hero.physicsBody?.categoryBitMask = CollisionBitMask.heroCategory
        hero.physicsBody?.collisionBitMask = CollisionBitMask.meteorCategory |  CollisionBitMask.sceneCategory | CollisionBitMask.bannerCategory
        hero.physicsBody?.contactTestBitMask = CollisionBitMask.meteorCategory | CollisionBitMask.coinsCategory | CollisionBitMask.sceneCategory | CollisionBitMask.bannerCategory
        self.addChild(hero)
    }
    
    func addCoins(){
        coins = SKSpriteNode(imageNamed: "coins")
        // Random spawn
        let actualX = random(min: size.width/2, max: size.width - coins.size.width/2)
        coins.position = CGPoint(x: actualX, y: size.height + size.height/2)
        coins.zPosition = 2
        //Add physics
        coins.physicsBody = SKPhysicsBody(circleOfRadius: max(coins.size.width/2, coins.size.height/2))
        coins.physicsBody?.usesPreciseCollisionDetection = true
        coins.physicsBody?.isDynamic = true
        coins.physicsBody?.categoryBitMask = CollisionBitMask.coinsCategory
        coins.physicsBody?.collisionBitMask = 0
        coins.physicsBody?.contactTestBitMask = CollisionBitMask.heroCategory
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX , y: -coins.size.height),
                                       duration: TimeInterval(3.0))
        let actionMoveDone = SKAction.removeFromParent()
        coins.run(SKAction.sequence([actionMove, actionMoveDone]))
        coins.name = "coin"
        self.addChild(coins)
    }
    
    
    func addMeteor() {
        meteor = SKSpriteNode(imageNamed: "meteor")
        // Random spawn
        let actualX = random(min: meteor.size.width/2, max: size.width - meteor.size.width/2)
        // Starting position
        meteor.position = CGPoint(x: actualX, y: size.height + size.height/2)
        meteor.zPosition = 2
        self.addChild(meteor)
        // Determine speed of the meteor
        let actualDuration = random(min: CGFloat(1.5), max: CGFloat(2.0))
        //Add physics
        meteor.physicsBody = SKPhysicsBody(circleOfRadius: max(meteor.size.width/2, meteor.size.height/2))
        meteor.physicsBody?.isDynamic = true
        meteor.physicsBody?.categoryBitMask = CollisionBitMask.meteorCategory
        meteor.physicsBody?.collisionBitMask = CollisionBitMask.heroCategory | CollisionBitMask.meteorCategory
        meteor.physicsBody?.contactTestBitMask = CollisionBitMask.heroCategory
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX , y: -meteor.size.height/2),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        meteor.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func createPoints(){
        let PointsTexture = SKTexture(imageNamed: "points")
        let animatePoints = SKAction.sequence([
            SKAction.wait(forDuration: 0.75, withRange: 0.2),
            SKAction.animate(with: [PointsTexture], timePerFrame: 0.05)
            ])
        let Points = SKSpriteNode(texture: PointsTexture)
        Points.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.9)
        Points.zPosition = 4
        Points.run(animatePoints)
        addChild(Points)
        Points.run(animatePoints, completion : {Points.removeFromParent()})
    }
    
    func createExplosion(){
        let ExplosionTexture = SKTexture(imageNamed: "explosion")
        let animateExplosion = SKAction.sequence([
            SKAction.wait(forDuration: 0, withRange: 0.2),
            SKAction.animate(with: [ExplosionTexture], timePerFrame: 0.05)
            ])
        let Explosion = SKSpriteNode(texture: ExplosionTexture)
        Explosion.position = CGPoint(x: hero.position.x, y: hero.position.y)
        Explosion.run(animateExplosion)
        addChild(Explosion)
        Explosion.run(animateExplosion, completion : {Explosion.removeFromParent()})
    }
    
    func createGameOverText(){
        gameOverText = SKLabelNode()
        gameOverText.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.8)
        gameOverText.text = NSLocalizedString("gameover", comment: "")
        gameOverText.fontColor = SKColor.white
        gameOverText.zPosition = 3
        gameOverText.fontSize = 30
        gameOverText.fontName = "Verdana"
        self.addChild(gameOverText)
    }
    
    func createGameOverScore(){
        gameOverScore = SKLabelNode()
        gameOverScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.7)
        gameOverScore.text = NSLocalizedString("yourscore", comment: "") + "\(score)"
        gameOverScore.fontColor = SKColor.white
        gameOverScore.zPosition = 3
        gameOverScore.fontSize = 20
        gameOverScore.fontName = "Verdana"
        self.addChild(gameOverScore)
    }
    
    func createGameOverRestart(){
        gameOverRestart = SKSpriteNode(imageNamed: "reset_over")
        gameOverRestart.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height/2)
        gameOverRestart.zPosition = 3
        self.addChild(gameOverRestart)
    }
    
    func createGameOverQuit(){
        gameOverQuit = SKSpriteNode(imageNamed: "back_over")
        gameOverQuit.position = CGPoint(x: self.frame.width/3, y: self.frame.height/2)
        gameOverQuit.zPosition = 3
        self.addChild(gameOverQuit)
    }
    
    func createGameOverMap(){
        gameOverMap = SKSpriteNode(imageNamed: "map")
        gameOverMap.position = CGPoint(x: self.frame.width/2, y: self.frame.height/3)
        gameOverMap.zPosition = 3
        self.addChild(gameOverMap)
    }
    
    //called when a new scene is created
    func createScene(){
        //Add physics to the scene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsWorld.contactDelegate = self
        //Add collision and contact detection
        self.physicsBody?.categoryBitMask = CollisionBitMask.sceneCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.heroCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.heroCategory
        //Load background
       self.backgroundColor = .black
        
    }
    
    //restart scene
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        score = 0
        createScene()
        //createBanner()
        //createPauseButton()
        //createRestartButton()
        //createScoreLabel()
        //star1()
        //star2()
        //addHero()
        //addCoins()
        //addMeteor()
    }
    
    //called when hero is destroyed
    func gameOver(){
        backButton.removeFromParent()
        scoreLbl.removeFromParent()
        pauseButton.removeFromParent()
        restartButton.removeFromParent()
        banner.removeFromParent()
        createGameOverText()
        createGameOverScore()
        createGameOverRestart()
        createGameOverQuit()
        createGameOverMap()
        self.view?.gestureRecognizers?.removeAll()
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}

extension ScoreScene{
    
    func createScoreBack(){
        scoreBackBtn = SKSpriteNode(imageNamed: "back")
        scoreBackBtn.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.94)
        scoreBackBtn.zPosition = 2
        self.addChild(scoreBackBtn)
    }
    
    func createHighscoreLabel(){
        highScore = SKLabelNode()
        highScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let defaults = UserDefaults.standard
        if let highestScore = defaults.object(forKey: "highestScore"){
            highScore.text = NSLocalizedString("highscore", comment: "") + "\(highestScore)"
        } else {
            highScore.text = NSLocalizedString("highscore", comment: "") + "0"
        }
        highScore.zPosition = 2
        highScore.fontSize = 30
        highScore.fontName = "Verdana"
        self.addChild(highScore)
    }
    
    func createCameraBtn(){
        cameraView = SKSpriteNode(imageNamed: "camera")
        cameraView.position = CGPoint(x: self.frame.width/2, y: self.frame.height/6)
        cameraView.zPosition = 2
        self.addChild(cameraView)
    }
}

extension MainMenuScene{
    
    //reset score
    func createResetScore(){
        resetScore = SKLabelNode()
        resetScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height/11)
        resetScore.text = NSLocalizedString("reinitscore", comment: "")
        resetScore.zPosition = 2
        resetScore.fontSize = 15
        resetScore.fontName = "Verdana Bold"
        self.addChild(resetScore)
    }
    
}



