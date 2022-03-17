//
//  ViewController.swift
//  Manila
//
//  Created by Neil Sardesai on 1/23/22.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBAction func neilSardesaiClicked(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://neilsardesai.com")!)
    }
    
}

