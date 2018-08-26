//
//  Bases Class.swift
//  AOW Attempt 1
//
//  Created by Bailey Still on 25/8/18.
//  Copyright © 2018 Bailey Still. All rights reserved.
//

import Foundation
import SpriteKit

class Bases: SKSpriteNode {
    var baseHealth = 5000
    
    func loadBase() {
        zPosition = -1
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.pinned = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 1
        physicsBody?.contactTestBitMask = 2
        physicsBody?.collisionBitMask = 2
    }
}

