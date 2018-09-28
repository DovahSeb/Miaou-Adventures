//
//  CreditsScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 21/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit

class CreditsScene: SKScene {
    
    //Declare Variables
    var creditsBackBtn = SKSpriteNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    } // required init
    
    override init(size: CGSize){
        super.init(size: size)
        //let viewSize:CGSize!
        //viewSize = size
        
        //Load Background
        self.backgroundColor = .black
        
        //Add back button
        createCreditsBack()
        
    } //init function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "creditsBack"{
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
} //class end

