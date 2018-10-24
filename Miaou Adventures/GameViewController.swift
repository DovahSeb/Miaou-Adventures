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

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        let mainScene = MainMenuScene(size: view.bounds.size)
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        mainScene.scaleMode = .aspectFill

        
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

    var prefersStatusBarHidden: Bool {
        return true
    }

