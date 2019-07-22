//
//  ViewController.swift
//  TapTempo
//
//  Created by Elliot Wesoff on 7/21/19.
//  Copyright © 2019 Elliot Wesoff. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var tempoField: NSTextField!
    var tt: TapTempo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tt = TapTempo()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func tap(_ sender: Any) {
        self.tempoField.stringValue = String(tt.tap())
    }
    
}

