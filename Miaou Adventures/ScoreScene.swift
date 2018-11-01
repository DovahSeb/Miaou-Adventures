//
//  ScoreScene.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 25/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import GoogleMobileAds

class ScoreScene: SKScene {
    
    //Declare Variables
    var background = SKSpriteNode()
    var highScore = SKLabelNode()
    var scoreBackBtn = SKSpriteNode()
    var cameraView = SKSpriteNode()

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
        
        //Add camera button
        createCameraBtn()
        
    } //init function
    
    override func didMove(to view: SKView) {
        
        //Hide banner ad
        let BannerAd = self.view?.viewWithTag(100) as! GADBannerView?
        BannerAd?.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //Called when a touch starts
        if let touch = touches.first{
            
            if scoreBackBtn.contains(touch.location(in: self)){
                scoreBackBtn.setScale(1.2)
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if cameraView.contains(touch.location(in: self)){
                cameraView.setScale(1.0)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier :"Camera")
                let currentViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
                
                currentViewController.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Called when a touch ends
        if let touch = touches.first{
            
            if scoreBackBtn.contains(touch.location(in: self)){
                scoreBackBtn.setScale(1.0)
            }
            
            if cameraView.contains(touch.location(in: self)){
                cameraView.setScale(1.0)
            }
        }
    }
} //class end
