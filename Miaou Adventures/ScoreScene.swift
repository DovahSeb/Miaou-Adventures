//
//  ScoreScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 25/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreScene: SKScene {
    
    //Declare Variables
    var background = SKSpriteNode()
    var highScore = SKLabelNode()
    var scoreBackBtn = SKSpriteNode()
    var mapView = SKSpriteNode()

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
        
        //Add highscore
        createHighscoreLabel()
        
        //Add back button
        createScoreBack()
        
        //Add map button
        createMapBtn()
        
    } //init function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if let touch = touches.first{
            
            if scoreBackBtn.contains(touch.location(in: self)){
                scoreBackBtn.setScale(1.2)
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if mapView.contains(touch.location(in: self)){
                mapView.setScale(1.2)
                let scene = MapView(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            
            if scoreBackBtn.contains(touch.location(in: self)){
                scoreBackBtn.setScale(1)
            }
        }
    }
} //class end
