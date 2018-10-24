//
//  HowToElements.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 22/10/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


extension HowToScene{
    
    //back button
    func createHowToBack(){
        howToBackBtn = SKSpriteNode(imageNamed: "back")
        howToBackBtn.position = CGPoint(x: self.frame.width/12, y: self.frame.height * 0.94)
        howToBackBtn.zPosition = 2
        self.addChild(howToBackBtn)
    }
    
    //how to play
    func createHowTo(){
        howTo = SKLabelNode()
        howTo.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.88)
        howTo.text = NSLocalizedString("howto", comment: "")
        howTo.zPosition = 2
        howTo.fontSize = 25
        howTo.fontName = "Verdana Bold"
        self.addChild(howTo)
    }
    
    //direction image
    func createDirectionImg(){
        directionImg = SKSpriteNode(imageNamed: "cat_hero")
        directionImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.8)
        directionImg.zPosition = 2
        directionImg.size = CGSize(width: 35, height: 35)
        self.addChild(directionImg)
    }
    
    //move your hero
    func createDirection(){
        direction = SKLabelNode()
        direction.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.75)
        direction.text = NSLocalizedString("move", comment: "")
        direction.zPosition = 2
        direction.fontSize = 19
        direction.fontName = "Verdana"
        self.addChild(direction)
    }
    
    //meteor image
    func createMeteorImg(){
        meteorImg = SKSpriteNode(imageNamed: "meteor")
        meteorImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.7)
        meteorImg.zPosition = 2
        meteorImg.size = CGSize(width: 35, height: 35)
        self.addChild(meteorImg)
    }
    
    //meteor text
    func createMeteorTxt(){
        meteorTxt = SKLabelNode()
        meteorTxt.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.65)
        meteorTxt.text = NSLocalizedString("meteor", comment: "")
        meteorTxt.zPosition = 2
        meteorTxt.fontSize = 19
        meteorTxt.fontName = "Verdana"
        self.addChild(meteorTxt)
    }
    
    //coin image
    func createCoinImg(){
        coinImg = SKSpriteNode(imageNamed: "coins")
        coinImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.6)
        coinImg.zPosition = 2
        coinImg.size = CGSize(width: 35, height: 35)
        self.addChild(coinImg)
    }
    
    //coin text
    func createCoinTxt(){
        coinTxt = SKLabelNode()
        coinTxt.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.55)
        coinTxt.text = NSLocalizedString("bonus", comment: "")
        coinTxt.zPosition = 2
        coinTxt.fontSize = 19
        coinTxt.fontName = "Verdana"
        self.addChild(coinTxt)
    }
    
    //map image
    func createMapImg(){
        mapImg = SKSpriteNode(imageNamed: "map")
        mapImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.5)
        mapImg.zPosition = 2
        mapImg.size = CGSize(width: 35, height: 35)
        self.addChild(mapImg)
    }
    
    //map text
    func createMapTxt(){
        mapTxt = SKLabelNode()
        mapTxt.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.45)
        mapTxt.text = NSLocalizedString("map", comment: "")
        mapTxt.zPosition = 2
        mapTxt.fontSize = 19
        mapTxt.fontName = "Verdana"
        self.addChild(mapTxt)
    }
    
    //camera image
    func createCameraImg(){
        cameraImg = SKSpriteNode(imageNamed: "camera")
        cameraImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.4)
        cameraImg.zPosition = 2
        cameraImg.size = CGSize(width: 35, height: 35)
        self.addChild(cameraImg)
    }
    
    //camera text
    func createCameraTxt(){
        cameraTxt = SKLabelNode()
        cameraTxt.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.35)
        cameraTxt.text = NSLocalizedString("camera", comment: "")
        cameraTxt.zPosition = 2
        cameraTxt.fontSize = 19
        cameraTxt.fontName = "Verdana"
        self.addChild(cameraTxt)
    }
}
