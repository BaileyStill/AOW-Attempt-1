//
//  Enemy.swift
//  AOW Attempt 1
//
//  Created by Bailey Still on 24/5/18.
//  Copyright © 2018 Bailey Still. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy:SKSpriteNode {
    
    var EnemyHealth = 100
    
    func loadEnemy() {
        
        // Sets Position and Name
        position = CGPoint(x: 240, y: -136)
        name = "enemy1"
        
        // Loads the Physics for the Enemy
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 1
        physicsBody?.collisionBitMask = 1
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.moveEnemy), userInfo: nil, repeats: false)
        
    }
    
    @objc func moveEnemy() {
        
        let enemyduration = CGFloat(8.0)
        let actionEmove = SKAction.move(to: CGPoint(x: -280,y: -136), duration: TimeInterval(enemyduration))
        self.run(SKAction.sequence([actionEmove]))
        
    }
    
    
}
