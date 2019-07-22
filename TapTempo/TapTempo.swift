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
    var times: [Date]
    var previousBpms: [Int]
    var firstTap: Bool
    
    override init() {
        self.times = []
        self.previousBpms = []
        self.firstTap = true
    }
    
    func tap() -> Int {
        self.times.append(Date())
        if self.times.count > 2 {
            self.times.remove(at: 0)
            return self.calculateBPM()
        } else {
            return 0
        }
    }
    
    func calculateBPM() -> Int {
        let t1 = self.times[0]
        let t2 = self.times[self.times.count - 1]
        let interval = t2.timeIntervalSince(t1)
        let bpm = Int(60 / interval)
        
        if self.firstTap == true {
            self.firstTap = false
            self.previousBpms = [bpm, bpm, bpm, bpm]
        }
        
        // stabilize because we're human.
        if self.previousBpms.count > 5 {
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
