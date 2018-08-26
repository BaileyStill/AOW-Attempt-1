//
//  GameScene.swift
//  AOW Attempt 1
//
//  Created by Bailey Still on 21/2/18.
//  Copyright © 2018 Bailey Still. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    let background = SKSpriteNode(imageNamed: "BackGround")
    let cam = SKCameraNode()

    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        bGround()
        ground()
        enemyBase()
        playerBase()
        
        // randomising time for each spawn
        let arraytime = [1,2,3,4,5,6,7,8,9]
        let ran = Int(arc4random_uniform(UInt32(arraytime.count)))
        let ranNum = arraytime[ran]
        //Timer for enemy spawn
        Timer.scheduledTimer(timeInterval: TimeInterval(ranNum), target: self, selector: #selector(self.spawnEnemy), userInfo: nil, repeats: true)
        
        //Setting up the camera and its position in the Scene
        cam.position = CGPoint(x: -100, y: 0)
        cam.xScale = 0.75
        cam.zPosition = 6
        self.camera = cam

        self.addChild(cam)
        
        func playerGUI() {
            let xpLab: SKLabelNode = SKLabelNode(fontNamed: "Copperplate")
            xpLab.fontSize = 14
            xpLab.fontColor = .black
            xpLab.text = "0"
            xpLab.position = CGPoint(x: 300, y: 120)
            
            cam.addChild(xpLab)
            
            let moneyLab: SKLabelNode = SKLabelNode(fontNamed: "Copperplate")
            moneyLab.fontSize = 14
            moneyLab.fontColor = .black
            moneyLab.text = "100"
            moneyLab.position = CGPoint(x: 300, y:145)
            
            cam.addChild(moneyLab)
        }
        
    }
    
    //Loading in the background image :)
    func bGround(){
        let background = SKSpriteNode(imageNamed: "BackGround")
        background.position = CGPoint(x:0 , y:0)
        background.zPosition = -5
        
        self.addChild(background)
    }
    
// Loading the players base through the instantiation of class Bases
    func playerBase(){
        let newPbase = Bases(imageNamed: "Base1")
        newPbase.loadBase()
        newPbase.position = CGPoint(x: -290 , y: -90)
        newPbase.name = "playerBase"
        self.addChild(newPbase)
    }
    
// Loading the enemy base through the instantiation of class Bases
    func enemyBase() {
        let newEbase = Bases(imageNamed: "Base1")
        newEbase.loadBase()
        newEbase.position = CGPoint(x: 560, y: -90)
        newEbase.name = "enemyBase"
        self.addChild(newEbase)
    }
//loading ground into scene
    func ground(){
        let imgGround = SKTexture(imageNamed:"Ground")
        let imgNode1 = SKSpriteNode(texture: imgGround)
        imgNode1.position = CGPoint(x: 0, y: -190)
        
        let Ground = SKTexture(imageNamed: "Ground")
        let Ground2 = SKSpriteNode(texture: Ground)
        Ground2.position = CGPoint(x: 400, y: -190)
        
        self.addChild(imgNode1)
        self.addChild(Ground2)
        
    }
    
    func updatePlayer() {
        
    }
    
    
    // Enemy Spawn through random enemy
    @objc func spawnEnemy() {
        let arrayEnemy = ["Enemy1", "Enemy 2"]
        let r = Int(arc4random_uniform(UInt32(arrayEnemy.count)))
        let enemyImg = arrayEnemy[r]
        
        let newEnemy = Enemy(imageNamed: enemyImg)
        newEnemy.loadEnemy()
        self.addChild(newEnemy)
    }
    // Troop Spawn func
    func spawnTroop1() {
        let newTroop = Player(imageNamed: "Troop1")
        newTroop.loadtroop()
        self.addChild(newTroop)
    }
    // 2nd Troop Spawn func
    func spawnTroop2() {
        let newTroop2 = Player(imageNamed: "Troop2")
        newTroop2.loadtroop()
        newTroop2.playerAttack = 40
        newTroop2.playerHealth = 75
        self.addChild(newTroop2)
    }
    
    
    
    // Pan Function connect to the camera Node used for scrolling between HomeBase and EnemyBase
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let loc = (touches.first?.location(in: self).x)
        let ploc = (touches.first?.previousLocation(in: self).x)
        let deltax = CGFloat(Double(loc!) - Double(ploc!))
        if (((self.camera?.position.x)! > CGFloat(-110)) && ((self.camera?.position.x)! < CGFloat(300))){
            self.camera?.position.x += (deltax * -1)
        }
        if ((self.camera?.position.x)! > CGFloat(300) && deltax > 0) {
            self.camera?.position.x += (deltax * -1)
        }
        if ((self.camera?.position.x)! < CGFloat(-110) && deltax < 0) {
            self.camera?.position.x += (deltax * -1)
        }
    }
    
    
    
    // the physics contact delegate handles all collisions and contacts between physics bodies
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == contact.bodyB.node?.name {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "enemy" && secondBody.node?.name == "playerBase" {
            let enemy = firstBody.node as! Enemy
            
            enemy.EnemyHealth -= 20
            print(enemy.EnemyHealth)
            if (enemy.EnemyHealth <= 0) {
                firstBody.node?.removeFromParent()
            }
        }
        
        if firstBody.node?.name == "enemy" && secondBody.node?.name == "troop"{
            let enemy = firstBody.node as! Enemy
            let troop = secondBody.node as! Player
            
            enemy.EnemyHealth -= troop.playerAttack
            troop.playerHealth -= enemy.enemyAttack
            print(enemy.EnemyHealth)
            print(troop.playerHealth)
            
            troop.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 0))
            enemy.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 0))
            
            if (enemy.EnemyHealth <= 0) {
                firstBody.node?.removeFromParent()
                
                let XP = cam.childNode(withName: "xpLab")
                XP.text = Int(XP.text!)!; +50
                
                
            } else if (troop.playerHealth <= 0){
                secondBody.node?.removeFromParent()
            }
        }
        
        if firstBody.node?.name == "troop" && secondBody.node?.name == "enemyBase"{
            let player = firstBody.node as! Player
            let Base = secondBody.node as! Bases
            
            player.playerHealth -= 20
            Base.baseHealth = Base.baseHealth - player.playerAttack
            print(player.playerHealth)
            print(Base.baseHealth)
            if(player.playerHealth <= 0){
                firstBody.node?.removeFromParent()
            }
        }
    }
}


