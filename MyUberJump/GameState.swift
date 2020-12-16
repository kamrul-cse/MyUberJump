//
//  GameState.swift
//  MyUberJump
//
//  Created by Md. Kamrul Hasan on 16/12/20.
//

import Foundation

class GameState {
    var score: Int
    var highScore: Int
    var stars: Int
    
    init() {
        // Init
        score = 0
        highScore = 0
        stars = 0
        
        // Load game state
        let defaults = UserDefaults.standard
        
        highScore = defaults.integer(forKey: "highScore")
        stars = defaults.integer(forKey: "stars")
    }
    
    class var sharedInstance: GameState {
        struct Singleton {
            static let instance = GameState()
        }
        
        return Singleton.instance
    }
    
    func saveState() {
        // Update highScore if the current score is greater
        highScore = max(score, highScore)
        
        // Store in user defaults
        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
        defaults.set(stars, forKey: "stars")
        UserDefaults.standard.synchronize()
    }
}
