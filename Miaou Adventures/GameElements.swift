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
    
    //Create banner on top
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
    
    //Create pause button
    func createPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.position = CGPoint(x: self.frame.width * 0.8, y: self.frame.height * 0.95)
        pauseButton.zPosition = 4
        self.addChild(pauseButton)
    }
    
    //Create restart button
    func createRestartButton(){
        restartButton = SKSpriteNode(imageNamed: "reset")
        restartButton.position = CGPoint(x: self.frame.width * 0.92, y: self.frame.height * 0.95)
        restartButton.zPosition = 4
        self.addChild(restartButton)
    }
    
    //Create back button
    func createBackButton(){
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.95)
        backButton.zPosition = 4
        self.addChild(backButton)
    }
    
    //Create score label
    func createScoreLabel(){
        scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.935)
        scoreLbl.text = "Score: 0"
        scoreLbl.fontColor = SKColor.white
        scoreLbl.zPosition = 4
        scoreLbl.fontSize = 20
        scoreLbl.fontName = "Verdana Bold"
        self.addChild(scoreLbl)
        let delay = SKAction.wait(forDuration: 0.5)
        let incrementScore = SKAction.run ({
            self.score += 1
            self.scoreLbl.text = "Score: " + "\(self.score)"
        })
        scoreLbl.run(SKAction.repeatForever(SKAction.sequence([delay,incrementScore])))
    }
    
    //setting backgroud stars
    func star1(){
        stars1 = SKSpriteNode(imageNamed: "stars")
        stars1.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        stars1.zPosition = 1
        let scrollDown = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height), duration: 4))
        stars1.run(scrollDown)
        self.addChild(stars1)
    }
    
    //setting background stars
    func star2(){
        stars2 = SKSpriteNode(imageNamed: "stars")
        stars2.position = CGPoint(x: self.frame.width/2, y: stars1.size.height + 1)
        stars2.zPosition = 1
        let scrollDown = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height), duration: 4))
        stars2.run(scrollDown)
        self.addChild(stars2)
    }
    
    //Create the hero
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
    
    //Create bonus points
    func addCoins(){
        coins = SKSpriteNode(imageNamed: "coins")
        // Random spawn
        let actualX = random(min: size.width/2, max: size.width - coins.size.width/2)
        coins.position = CGPoint(x: actualX, y: size.height + size.height/2)
        coins.zPosition = 2
        //Add physics
        coins.physicsBody?.isDynamic = true
        coins.physicsBody?.categoryBitMask = CollisionBitMask.coinsCategory
        coins.physicsBody?.collisionBitMask = 0
        coins.physicsBody?.contactTestBitMask = 0
        let actionMove = SKAction.move(to: CGPoint(x: actualX , y: -coins.size.height),
                                       duration: TimeInterval(3.0))
        let actionMoveDone = SKAction.removeFromParent()
        coins.run(SKAction.sequence([actionMove, actionMoveDone]))
        coins.name = "coin"
        self.addChild(coins)
    }
    
    //Create the meteor shower
    func addMeteor() {
        meteor = SKSpriteNode(imageNamed: "meteor")
        // Random spawn
        let actualX = random(min: meteor.size.width/2, max: size.width - meteor.size.width/2)
        // Starting position
        meteor.position = CGPoint(x: actualX, y: size.height + size.height/2)
        meteor.zPosition = 2
        self.addChild(meteor)
        // Determine speed of the meteor
        var actualDuration = random(min: CGFloat(1.5), max: CGFloat(2.0))
        if score > 100 {
            actualDuration = random(min: CGFloat(1.0), max: CGFloat(1.5))
        } else if score > 200 {
            actualDuration = random(min: CGFloat(0.75), max: CGFloat(1.0))
        }
        //Add physics
        meteor.physicsBody = SKPhysicsBody(circleOfRadius: max(meteor.size.width/4, meteor.size.height/4))
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
    
    //Points texture
    func createPoints(){
        let PointsTexture = SKTexture(imageNamed: "points")
        let animatePoints = SKAction.sequence([
            SKAction.wait(forDuration: 0.75, withRange: 0.2),
            SKAction.animate(with: [PointsTexture], timePerFrame: 0.05)
            ])
        let Points = SKSpriteNode(texture: PointsTexture)
        Points.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.85)
        Points.zPosition = 4
        Points.run(animatePoints)
        addChild(Points)
        Points.run(animatePoints, completion : {Points.removeFromParent()})
    }
    
    //Explosion effect
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
    
    //Game over text
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
    
    //Game over final score
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
    
    //Restart button on game over
    func createGameOverRestart(){
        gameOverRestart = SKSpriteNode(imageNamed: "reset_over")
        gameOverRestart.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height/2)
        gameOverRestart.zPosition = 3
        self.addChild(gameOverRestart)
    }
    
    //Back button on game over
    func createGameOverQuit(){
        gameOverQuit = SKSpriteNode(imageNamed: "back_over")
        gameOverQuit.position = CGPoint(x: self.frame.width/3, y: self.frame.height/2)
        gameOverQuit.zPosition = 3
        self.addChild(gameOverQuit)
    }
    
    //Map button on game over
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

extension MainMenuScene{
    
    //reset score
    func createResetScore(){
        resetScore = SKLabelNode()
        resetScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height/11)
        resetScore.text = NSLocalizedString("reinitscore", comment: "")
        resetScore.zPosition = 2
        resetScore.fontSize = 14
        resetScore.fontName = "Verdana Bold"
        self.addChild(resetScore)
    }
    
}

extension MapView{
    
    //back button
    func createMapBackBtn(){
        mapBackBtn = SKSpriteNode(imageNamed: "back")
        mapBackBtn.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.95)
        mapBackBtn.zPosition = 3
        self.addChild(mapBackBtn)
    }
    
    //banner
    func createMapBanner(){
        let mapBannerSize = CGSize(width: frame.size.width, height: frame.size.height/9.5)
        mapBanner = SKShapeNode(rectOf: mapBannerSize)
        mapBanner.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.95)
        mapBanner.zPosition = 2
        mapBanner.fillColor = UIColor(red:87/255, green:182/255, blue:170/255, alpha: 1)
        self.addChild(mapBanner)
    }
}



