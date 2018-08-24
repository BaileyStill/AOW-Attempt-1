//
//  Player Class.swift
//  AOW Attempt 1
//
//  Created by Bailey Still on 22/5/18.
//  Copyright © 2018 Bailey Still. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    var playerHealth = 100
    var playerAttack = 10
    
    func pickTroop() {
//        var Trooparray = ["Troop1","Troop2"]
//        var arrayIndex: Int = 0
        
    }
    
    func loadtroop()
    {
        //setting position and name of SpriteNode
        position = CGPoint(x:-280, y:-136)
        name = "troop1"
        zPosition = 1
        
        // player physics body
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 1
        physicsBody?.contactTestBitMask = 2
        physicsBody?.collisionBitMask = 2
        
        moveTroop()

    }
    
    @objc func moveTroop() {
        let tPath = UIBezierPath()
        tPath.move(to: CGPoint(x:0, y:0))
        tPath.addLine(to: CGPoint(x: 800, y:0))

        let troopMove = SKAction.follow(tPath.cgPath, asOffset: true, orientToPath: false, speed: 30)
        self.run(troopMove)
    }
    
//    @objc func pCollision() {
//        
//        let collisionPath = UIBezierPath()
//        collisionPath.move(to: CGPoint(x: 0, y: 0))
//        collisionPath.addLine(to: CGPoint(x: -200, y: 0))
//        
//        let actionBounce = SKAction.follow(collisionPath.cgPath, asOffset: true, orientToPath: false, speed: 200)
//        self.run(actionBounce)
//        
//        
//    }
}


