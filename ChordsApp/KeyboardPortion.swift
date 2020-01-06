//
//  KeyboardPortion.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import UIKit
import Stevia

class KeyboardPortion: UIView {
    
    // Whites
    let C = WhiteKey(name: "C")
    let D = WhiteKey(name: "D")
    let E = WhiteKey(name: "E")
    let F = WhiteKey(name: "F")
    let G = WhiteKey(name: "G")
    let A = WhiteKey(name: "A")
    let B = WhiteKey(name: "B")
    
    // Blacks
    let Csharp = BlackKey(name: "C#")
    let Dsharp = BlackKey(name: "D#")
    let Fsharp = BlackKey(name: "F#")
    let Gsharp = BlackKey(name: "G#")
    let Asharp = BlackKey(name: "A#")
    
    var notes: [Key] = [Key]()
    var whites: [Key] = [Key]()
    var blacks: [Key] = [Key]()
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .black
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.88, constant: 0).isActive = true
        
        notes = [C, Csharp, D, Dsharp, E, F, Fsharp, G, Gsharp, A, Asharp, B]
    
        whites = notes.filter { $0 is WhiteKey }
        blacks = notes.filter { $0 is BlackKey }
        
        var previousKey: UIView? = nil
        whites.enumerated().forEach { i, key in
            
            sv(
                key
            )
            
            if i == 0 {
                key.left(0)
            } else {
                if let previousKey = previousKey {
                    previousKey-1-key
                    key.Width == previousKey.Width
                }
            }
            
            key.fillVertically()
            
            if i == whites.count-1 {
                key.right(0)
            }
            previousKey = key
        }
        
        blacks.forEach { sv($0) }

        blacks.forEach {
            $0.Height == C.Height * 0.66
            $0.Width == C.Width * 0.6
            $0.top(0)
        }

        Csharp.CenterX == C.Right
        Dsharp.CenterX == D.Right
        Fsharp.CenterX == F.Right
        Gsharp.CenterX == G.Right
        Asharp.CenterX == A.Right
    }
}
