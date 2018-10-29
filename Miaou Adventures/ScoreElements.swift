//
//  ScoreElements.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 23/10/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit

extension ScoreScene{
    
    //Create back button
    func createScoreBack(){
        scoreBackBtn = SKSpriteNode(imageNamed: "back")
        scoreBackBtn.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.95)
        scoreBackBtn.zPosition = 2
        self.addChild(scoreBackBtn)
    }
    
    //Create high score label
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
    
    //Create access to camera button
    func createCameraBtn(){
        cameraView = SKSpriteNode(imageNamed: "camera")
        cameraView.position = CGPoint(x: self.frame.width/2, y: self.frame.height/6)
        cameraView.zPosition = 2
        self.addChild(cameraView)
    }
}
