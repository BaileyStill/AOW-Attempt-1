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
    var playerHealth = 200
    
    func pickTroop() {
//        var Trooparray = ["Troop1","Troop2"]
//        var arrayIndex: Int = 0
        
    }
    
    func loadtroop()
    {
        //setting position and name of SpriteNode
        position = CGPoint(x:-280, y:-136)
        name = "troop1"
        
        // player physics body
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 1
        physicsBody?.contactTestBitMask = 2
        physicsBody?.collisionBitMask = 2
        
        let troopMovement = CGFloat(8.0)
        
        let actionTMove = SKAction.move(to: CGPoint(x:240, y:-136), duration: TimeInterval(troopMovement))
        run(SKAction.sequence([actionTMove]))
    }
}


