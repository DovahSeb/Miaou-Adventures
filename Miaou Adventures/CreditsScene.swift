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
        self.addChild(BG)
        
        //Add end credits
        
    } //init function
    
} //class end

