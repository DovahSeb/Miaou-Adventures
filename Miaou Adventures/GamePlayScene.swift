//
//  GamePlayScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 20/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
    //Declare bitmasks
    struct CollisionBitMask {
        static let heroCategory:UInt32 = 0x1 << 0
        static let meteorCategory:UInt = 0x1 << 1
    }
    
    //Declare variables
    var stars1 = SKSpriteNode()
    var stars2 = SKSpriteNode()
    var stars3 = SKSpriteNode()
    var scr_vert = SKAction()
    var hero = SKSpriteNode()
    var motionManager = CMMotionManager()
    var meteor = SKSpriteNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      
        
    } // required init
    
    override init(size: CGSize){
        super.init(size: size)
        
        let viewSize:CGSize!
        viewSize = size
        
        //Add physics to the scene
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        //Load motionmanager
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        //Load background
        self.backgroundColor = .black
        
        //Load stars image
        stars1 = SKSpriteNode(imageNamed: "stars")
        stars1.position = CGPoint(x: 0, y: 0)
        self.addChild(stars1)
        
        stars2 = SKSpriteNode(imageNamed: "stars")
        stars2.position = CGPoint(x: 0, y: self.frame.size.height)
        self.addChild(stars2)
        
        stars3 = SKSpriteNode(imageNamed: "stars")
        stars3.position = CGPoint(x: 0, y: self.frame.size.height + stars2.position.y)
        self.addChild(stars3)
        
        //background scroll vertically
        scr_vert = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height), duration: 5))
        stars1.run(scr_vert); stars2.run(scr_vert); stars3.run(scr_vert)
        
        //Load hero
        hero = SKSpriteNode(imageNamed: "cat_hero")
        hero.position = CGPoint(x: viewSize.width/2, y: viewSize.height/10)
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
        
        func random() -> CGFloat {
            return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        }
        
        func random(min: CGFloat, max: CGFloat) -> CGFloat {
            return random() * (max - min) + min
        }
        
        func addMeteor() {
            meteor = SKSpriteNode(imageNamed: "meteor")
            
            // Random spawn
            let actualX = random(min: meteor.size.width/2, max: size.width - meteor.size.width/2)
            
            // Starting position
            meteor.position = CGPoint(x: actualX, y: size.height + meteor.size.height/2)
            addChild(meteor)
            
            // Determine speed of the monster
            let actualDuration = random(min: CGFloat(2.0), max: CGFloat(3.5))
            
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
        
        //Start meteor function
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMeteor),
                                                      SKAction.wait(forDuration: 1.0)])))
        
        
    } //init function
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if stars1.position.y <= -self.frame.size.height {
            stars1.position.y = self.frame.size.height
            //this ensures that your backgrounds line up perfectly
        }
        if stars2.position.y <= -self.frame.size.height {
            stars2.position.y = self.frame.size.height
            //this ensures that your backgrounds line up perfectly
        }
        if stars3.position.y <= -self.frame.size.height {
            stars3.position.y = self.frame.size.height
            //this ensures that your backgrounds line up perfectly
        }
        if let accelerometerData = motionManager.accelerometerData {
            hero.physicsBody!.applyForce(CGVector(dx: 100 * CGFloat(accelerometerData.acceleration.x), dy: 100 * CGFloat(accelerometerData.acceleration.y)))
        }
    }
    
    
    
} //class end
