//
//  Key.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import UIKit
import Stevia

protocol Key: UIView {
    var overlay: UIView { get }
    func show()
    func reset()
}

class WhiteKey: UIView, Key {

    let label = UILabel()
    let overlay = UIView()
    
    convenience init(name: String, color: UIColor = UIColor(named: "keyGreen")!) {
        self.init(frame: .zero)
        backgroundColor = .white
        
        sv (
            overlay,
            label
        )
        
        overlay.fillContainer()
        label.centerHorizontally()
        label.bottom(20)
        
        layer.cornerRadius = 10
        overlay.backgroundColor = color
        overlay.layer.cornerRadius = 10
        label.textColor = .white
        
        overlay.isHidden = true
        label.isHidden = true
        label.text = name
    }
    
    func show() {
        overlay.isHidden = false
        label.isHidden = false
    }
    
    func reset() {
        overlay.isHidden = true
        label.isHidden = true
    }
}

class BlackKey: UIView, Key {
    
    let label = UILabel()
    let overlay = UIView()
    
    convenience init(name: String, color: UIColor = UIColor(named: "keyGreen")!) {
        self.init(frame: .zero)
        backgroundColor = .black
        
        sv (
            overlay,
            label
        )
        
        overlay.fillContainer()
        label.centerHorizontally()
        label.bottom(20)
        
        layer.cornerRadius = 5
        overlay.backgroundColor = color
        overlay.layer.cornerRadius = 5
        label.textColor = .white
        
        overlay.isHidden = true
        label.isHidden = true
        label.text = name
    }
    
    func show() {
        overlay.isHidden = false
        label.isHidden = false
    }
    
    func reset() {
        overlay.isHidden = true
        label.isHidden = true
    }
}

