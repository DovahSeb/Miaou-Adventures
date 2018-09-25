//
//  GameElements.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 25/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit

extension GamePlayScene{
    
    func createPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.position = CGPoint(x: self.frame.width * 0.8, y: self.frame.height * 0.94)
        pauseButton.zPosition = 3
        pauseButton.size = CGSize(width: 30, height: 30)
        self.addChild(pauseButton)
    }
    
    func createRestartButton(){
        restartButton = SKSpriteNode(imageNamed: "reset")
        restartButton.position = CGPoint(x: self.frame.width * 0.9, y: self.frame.height * 0.94)
        restartButton.zPosition = 3
        restartButton.size = CGSize(width: 30, height: 30)
        self.addChild(restartButton)
        restartButton.run(SKAction.scale(to: 1.0, duration: 0.5))
    }
    
    func createBackButton(){
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.94)
        backButton.zPosition = 3
        self.addChild(backButton)
    }
    
    func createScoreLabel(){
        scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.92)
        scoreLbl.text = "Score: 0"
        scoreLbl.fontColor = SKColor.white
        scoreLbl.zPosition = 3
        scoreLbl.fontSize = 20
        scoreLbl.fontName = "Arial"
        self.addChild(scoreLbl)
        //return scoreLbl
    }
    
    func star1(){
        stars1 = SKSpriteNode(imageNamed: "stars")
        stars1.position = CGPoint(x: 0, y: 0)
        stars1.zPosition = 1
        self.addChild(stars1)
        let scrollDown = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height), duration: 5))
        stars1.run(scrollDown)
    }
    
    func addHero(){
        hero = SKSpriteNode(imageNamed: "cat_hero")
        hero.position = CGPoint(x: self.frame.width/2, y: self.frame.height/10)
        hero.zPosition = 2
        //Add physics
        hero.physicsBody = SKPhysicsBody(texture: hero.texture!,
                                         size: hero.texture!.size())
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.affectedByGravity = false
        hero.physicsBody?.mass = 0.2
        hero.physicsBody?.allowsRotation = false
        hero.physicsBody?.linearDamping = 0.5
        self.addChild(hero)
        hero.name = "hero"
    }
    
    func addMeteor() {
        meteor = SKSpriteNode(imageNamed: "meteor")
        // Random spawn
        let actualX = random(min: meteor.size.width/2, max: size.width - meteor.size.width/2)
        // Starting position
        meteor.position = CGPoint(x: actualX, y: size.height + meteor.size.height/2)
        meteor.zPosition = 2
        addChild(meteor)
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(2.5))
        //Add physics
        meteor.physicsBody = SKPhysicsBody(texture: meteor.texture!,
                                           size: meteor.texture!.size())
        meteor.physicsBody?.isDynamic = true
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX , y: -meteor.size.height/2),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        meteor.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func createScene(){
        //Add physics to the scene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsWorld.contactDelegate = self
        //Load background
        self.backgroundColor = .black
    }
    
    //restart scene
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        score = 0
        createScene()
        createPauseButton()
        createRestartButton()
        createScoreLabel()
        star1()
        addHero()
        addMeteor()
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
        scoreBackBtn.name = "scoreBack"
    }
    
    
    func createHighscoreLabel(){
        highScore = SKLabelNode()
        highScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let defaults = UserDefaults.standard
        if let highestScore = defaults.object(forKey: "highestScore"){
            highScore.text = "High Score: \(highestScore)"
        } else {
            highScore.text = "High Score: 0"
        }
        highScore.zPosition = 2
        highScore.fontSize = 30
        highScore.fontName = "Arial"
        self.addChild(highScore)
        //return highScore
    }
}

extension MainMenuScene{
    
    //reset score
    func createResetScore(){
        resetScore = SKLabelNode()
        resetScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height/10)
        resetScore.text = "Reset Score"
        resetScore.zPosition = 2
        resetScore.fontSize = 15
        resetScore.fontName = "Ready Player One"
        self.addChild(resetScore)
    }
    
}


