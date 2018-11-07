//
//  GameViewController.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 19/09/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        let mainScene = MainMenuScene(size: view.bounds.size)
        
        //Configure ad banner
        let customAdSize = GADAdSizeFromCGSize(CGSize(width: self.view.frame.width, height: 50))
        let BannerAd = DFPBannerView(adSize: customAdSize)
        BannerAd.frame = CGRect(x: 0, y: 0, width: BannerAd.frame.width, height: 50)
        BannerAd.tag = 100
        BannerAd.delegate = self
        BannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerAd.rootViewController = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b"]
        BannerAd.load(request)
        view.addSubview(BannerAd)
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        mainScene.scaleMode = .resizeFill
        skView.presentScene(mainScene)
        
        SoundManager.sharedInstance.startPlaying()
        }
    }
     
     var shouldAutorotate: Bool {
        return false
    }

     var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    //Hide status bar
    var prefersStatusBarHidden: Bool {
        return true
    }



