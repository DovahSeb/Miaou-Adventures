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
    var highScore = SKLabelNode()
    var scoreBackBtn = SKSpriteNode()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    } // required init
    
    override init(size: CGSize){
        super.init(size: size)
        let viewSize:CGSize!
        viewSize = size
        
        //Load Background
        let BG = SKSpriteNode(imageNamed: "BG")
        BG.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        BG.zPosition = 1
        self.addChild(BG)
        
        //Add highscore
        createHighscoreLabel()
        
        //Add back button
        createScoreBack()
        
    } //init function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "scoreBack"{
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .up, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
} //class end
