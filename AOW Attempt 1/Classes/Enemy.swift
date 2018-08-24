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
    var enemyAttack = 10
    
    func loadEnemy() {
        
// Sets Position and Name
        position = CGPoint(x: 550, y: -136)
        name = "enemy1"
        zPosition = 1
        
// Loads the Physics for the Enemy
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 1
        physicsBody?.collisionBitMask = 1
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.moveEnemy), userInfo: nil, repeats: false)
        
    }
//function for moving enemy along set path to user base
    @objc func moveEnemy() {

        let Epath = UIBezierPath()
        Epath.move(to: CGPoint(x: 0, y: 0))
        Epath.addLine(to: CGPoint(x: -800, y:0))
        
        let actionMoce = SKAction.follow(Epath.cgPath, asOffset: true, orientToPath: false, speed: 30)
        self.run(actionMoce)
    }
    
//    @objc func eCollision() {
//        let collisionPath = UIBezierPath()
//        collisionPath.move(to: CGPoint(x: 0 ,y: 0))
//        collisionPath.addLine(to: CGPoint(x: 200, y: 0))
//
//        let actionBounce = SKAction.follow(collisionPath.cgPath, asOffset: true, orientToPath: false, speed: 200)
//        self.run(actionBounce)
//
//    }
}
