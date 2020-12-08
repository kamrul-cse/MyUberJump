//
//  GameObjectNode.swift
//  MyUberJump
//
//  Created by Md. Kamrul Hasan on 8/12/20.
//

import SpriteKit

enum PlatformType: Int {
    case normal = 0
    case breaking
}

enum StarType: Int {
    case normal = 0
    case special
}

struct CollisionCategoryBitmask {
    static let player: UInt32 = 0x00
    static let star: UInt32 = 0x01
    static let platform: UInt32 = 0x02
}


class GameObjectNode: SKNode {
    func collisionWithPlayer(player: SKNode) -> Bool {
        return false
    }
    
    func checkNodeRemoval(playerY: CGFloat) {
        if playerY > self.position.y + 300.0 {
            self.removeFromParent()
        }
    }
}

class StarNode: GameObjectNode {
    var starType: StarType!
    let starSound = SKAction.playSoundFileNamed("StarPing.wav", waitForCompletion: false)
    
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        // Boost the player up
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)
        
        // Play sound
        run(starSound, completion: {
            // Remove this Star
            self.removeFromParent()
        })
        
        // The HUD needs updating to show the new stars and score
        return true
    }
}

class PlatformNode: GameObjectNode {
    var platformType: PlatformType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        guard let physicsBody = player.physicsBody else { return false }
        // 1
        // Only bounce the player if he's falling
        if physicsBody.velocity.dy < 0 {
            // 2
            player.physicsBody?.velocity = CGVector(dx: physicsBody.velocity.dx, dy: 250.0)
            
            // 3
            // Remove if it is a Break type platform
            if platformType == .breaking {
                self.removeFromParent()
            }
        }
        
        // 4
        // No stars for platforms
        return false
    }
}
