//
//  CreditsScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 21/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit

class HowToScene: SKScene {
    
    //Declare Variables
    var background = SKSpriteNode()
    var howToBackBtn = SKSpriteNode()
    var howTo = SKLabelNode()
    var directionImg = SKSpriteNode()
    var direction = SKLabelNode()
    var coinImg = SKSpriteNode()
    var meteorImg = SKSpriteNode()
    var meteorTxt = SKLabelNode()
    var coinTxt = SKLabelNode()
    var mapImg = SKSpriteNode()
    var mapTxt = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    } // required init
    
    override init(size: CGSize){
        super.init(size: size)
        let viewSize:CGSize!
        viewSize = size
        
        //Load background
        background = SKSpriteNode(imageNamed: "BG")
        background.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        background.zPosition = 1
        self.addChild(background)
        
        //Add back button
        createHowToBack()
        
        //Add how to text
        createHowTo()
        
        //Add direction sprite
        createDirectionImg()
        
        //Add direction text
        createDirection()
        
        //Add meteor sprite
        createMeteorImg()
        
        //Add meteor text
        createMeteorTxt()
        
        //Add coin sprite
        createCoinImg()
        
        //Add coin text
        createCoinTxt()
        
        //Add map img
        createMapImg()
        
        //Add map text
        createMapTxt()
        
    } //init function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touch = touches.first{
            
            if howToBackBtn.contains(touch.location(in: self)){
                howToBackBtn.setScale(1.2)
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if howToBackBtn.contains(touch.location(in: self)){
                howToBackBtn.setScale(1)
            }
        }
    }
    
} //class end

