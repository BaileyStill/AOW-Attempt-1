//
//  GameScene.swift
//  AOW Attempt 1
//
//  Created by Bailey Still on 21/2/18.
//  Copyright © 2018 Bailey Still. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
//    var enemy: SKSpriteNode!
    var playerBase: SKSpriteNode!
    var buttonT1: SKNode! = nil
//    var troop1: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        backcolor()
        Base1()
        ground()

        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.spawnEnemy), userInfo: nil, repeats: true)
        
        physicsWorld.contactDelegate = self
        
        let camera = SKCameraNode()
        camera.position = CGPoint(x: 0, y: 0)
        self.camera = camera
        self.addChild(camera)
        
        buttonT1 = SKSpriteNode(color: SKColor.red, size: CGSize(width:30, height:30))
        buttonT1.position = CGPoint(x:-320, y:150)

        self.addChild(buttonT1)

    }
    
    @objc func spawnEnemy() {
        
        let newEnemy = Enemy(imageNamed: "Enemy1")
        newEnemy.loadEnemy()
        self.addChild(newEnemy)
        
    }
    
    func spawnTroop() {
        let newTroop = Player(imageNamed: "Troop1")
        newTroop.loadtroop()
        newTroop.zPosition = 1
        self.addChild(newTroop)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let edgepan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgepan.edges = .left
        
        GameScene.addGestureRecognizer(edgepan)
    }
    
    @objc func screenEdgeSwiped(_ recognizer:UIScreenEdgePanGestureRecognizer)
    {
        if recognizer.state == .recognized {
            
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if buttonT1.contains(location){
                spawnTroop()
            }
        }
    }
    // the physics contact delegate handles all collisions and contacts between physics bodies
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "enemy1" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "enemy1" && secondBody.node?.name == "playerBase" {
            let enemy = firstBody.node as! Enemy
            enemy.EnemyHealth -= 20
            print(enemy.EnemyHealth)
            if (enemy.EnemyHealth <= 0) {
                firstBody.node?.removeFromParent()
            }
        }
        
        if firstBody.node?.name == "enemy1" && secondBody.node?.name == "troop1"{
                        
            let array = ["1","2"]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            let randomitem = array[randomIndex]

            if randomitem == "1" {
                firstBody.node?.removeFromParent()
            }else {
                secondBody.node?.removeFromParent()
            }
        }
        
    }
    
    
    func backcolor() {
        let backcolour = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.14, brightness: 0.97, alpha: 1), size: CGSize(width: frame.width, height: frame.height))
        backcolour.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(backcolour)
            }
    
    func Base1(){
        let Basetexture = SKTexture(imageNamed: "Base1")
        playerBase = SKSpriteNode(texture: Basetexture)
        playerBase.position = CGPoint(x: -290 , y: -90)
        playerBase.name = "playerBase"
        
        self.addChild(playerBase)
        
        playerBase.physicsBody = SKPhysicsBody(texture: Basetexture, size: Basetexture.size())
        playerBase.physicsBody?.isDynamic = false
        playerBase.physicsBody?.pinned = true
        playerBase.physicsBody?.affectedByGravity = false
        playerBase.physicsBody?.categoryBitMask = 1
        playerBase.physicsBody?.contactTestBitMask = 2
        playerBase.physicsBody?.collisionBitMask = 2
        
    }
    
    func ground(){
        let imgGround = SKTexture(imageNamed:"Ground")
        let imgNode1 = SKSpriteNode(texture: imgGround)
        imgNode1.position = CGPoint(x: 0, y: -190)
        
        self.addChild(imgNode1)
        
        imgNode1.physicsBody = SKPhysicsBody(texture: imgGround, size: imgGround.size())
        imgNode1.physicsBody?.pinned = true
        imgNode1.physicsBody?.affectedByGravity = false
        imgNode1.physicsBody?.isDynamic = false
        
    }


}
