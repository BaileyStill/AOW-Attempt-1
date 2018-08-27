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
    var enemyAttack = 25
    
    func loadEnemy() {
        
// Sets Position and Name
        position = CGPoint(x: 545, y: -136)
        name = "enemy"
        zPosition = 1
        
// Loads the Physics for the Enemy
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 1
        physicsBody?.collisionBitMask = 1
        
        moveEnemy()
    }
    
    
//function for moving enemy along set path to user base
    @objc func moveEnemy() {

        let Epath = UIBezierPath()
        Epath.move(to: CGPoint(x: 0, y: 0))
        Epath.addLine(to: CGPoint(x: -850, y:0))
        
        let actionMoce = SKAction.follow(Epath.cgPath, asOffset: true, orientToPath: false, speed: 30)
        self.run(actionMoce)
    }
}


