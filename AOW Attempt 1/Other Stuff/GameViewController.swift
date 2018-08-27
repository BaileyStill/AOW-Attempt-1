//
//  GameViewController.swift
//  AOW Attempt 1
//
//  Created by Bailey Still on 21/2/18.
//  Copyright © 2018 Bailey Still. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        let scene = GameScene(size: skView.frame.size)
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    
    @IBAction func TroopB1(_ sender: AnyObject) {
        ((self.view as? SKView)?.scene as? GameScene)?.spawnTroop1()
    }
    @IBAction func TroopB2(_ sender: AnyObject) {
        ((self.view as? SKView)?.scene as? GameScene)?.spawnTroop2()
        
        
    }
    @IBAction func NEButton(_ sender: AnyObject) {
        let xpValue = Int((((self.view as? SKView)?.scene as? GameScene)?.xpLab.text!)!)!
        
        if (xpValue >= 2000) {
            ((self.view as? SKView)?.scene as? GameScene)?.xpLab.text = String(Int((((self.view as? SKView)?.scene as? GameScene)?.xpLab.text!)!)! - 2000)
            
            for child in (((self.view as? SKView)?.scene as? GameScene)?.children)! {
                if ((child.name == "playerBase") || (child.name == "enemyBase")) {
                    let base = child as! Bases
                    base.texture = SKTexture(imageNamed: "Base2")
                    base.position.y += 30
                    base.baseHealth = base.baseHealth + 1000
                    
            
                }
            }
        }
    }
}


