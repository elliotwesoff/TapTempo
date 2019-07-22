//
//  TapTempo.swift
//  TapTempo
//
//  Created by Elliot Wesoff on 7/21/19.
//  Copyright © 2019 Elliot Wesoff. All rights reserved.
//

import Cocoa
import Foundation

class TapTempo: NSObject {
    var lastTap: Date!
    var previousBpms: [Int]
    var firstTap: Bool
    let stabilizer = 3
    
    override init() {
        self.previousBpms = []
        self.firstTap = true
    }
    
    func tap() -> Int {
        if self.firstTap == true {
            self.firstTap = false
            self.lastTap = Date()
            return 0
        } else {
            let bpm = self.calculateBPM()
            self.lastTap = Date()
            return bpm
        }
    }
    
    func calculateBPM() -> Int {
        let now = Date()
        let interval = now.timeIntervalSince(self.lastTap)
        let bpm = Int(60 / interval)
        
        // stabilize because we're human.
        if self.previousBpms.count > self.stabilizer {
            self.previousBpms.remove(at: 0)
        }
        
        self.previousBpms.append(bpm)
        return self.averageBpms()
    }
    
    func averageBpms() -> Int {
        let sum = self.previousBpms.reduce(0, +)
        return sum / self.previousBpms.count
    }
    
}
