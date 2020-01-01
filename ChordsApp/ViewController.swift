//
//  ViewController.swift
//  ChordsApp
//
//  Created by Sacha on 23/12/2019.
//  Copyright © 2019 sachadso. All rights reserved.
//

import UIKit
import Chords
import Stevia

class ViewController: UIViewController {
    
    let engine = ChordsEngine()
    let field = UITextField()
    let keyboard = Keyboard()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.sv (
            field,
            keyboard
        )
        
        field.Top == view.safeAreaLayoutGuide.Top + 20
        view.layout(
            |-40-field-40-|,
            40,
            |keyboard|
        )
        
        field.becomeFirstResponder()
        field.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        field.style { f in
            f.font = UIFont.systemFont(ofSize: 60, weight: .bold)
            f.textAlignment = .center
            f.autocorrectionType = .no
        }
        
        field.placeholder = "Cdim7"
    }
    
    @objc func textChanged() {
        updateChord(field.text!)
    }
    
    func updateChord(_ string: String) {
        keyboard.resetDisplay()
        if let chordFound = engine.chordFor(string: string) {
            keyboard.display(chord: chordFound)
        }
    }
}

// Goal autolayout keyboard.

class Keyboard: UIView {
    
    let keyboardPortion = KeyboardPortion()
    
    convenience init() {
        self.init(frame: .zero)
        
        sv(
            keyboardPortion
        )
        
        keyboardPortion.fillContainer()
    }
    
    func resetDisplay() {
        keyboardPortion.notes.forEach { $0.reset() }
    }
    
    func display(chord: Chord) {
        
        chord.notes().forEach { note in
            
            switch note {
            case C:
                keyboardPortion.C.show()
            case Csharp:
                keyboardPortion.Csharp.show()
            case D:
                keyboardPortion.D.show()
            case Dsharp:
                keyboardPortion.Dsharp.show()
            case E:
                keyboardPortion.E.show()
            case F:
                keyboardPortion.F.show()
            case Fsharp:
                keyboardPortion.Fsharp.show()
            case G:
                keyboardPortion.G.show()
            case Gsharp:
                keyboardPortion.Gsharp.show()
            case A:
                keyboardPortion.A.show()
            case Asharp:
                keyboardPortion.Asharp.show()
            case B:
                keyboardPortion.B.show()
            default: ()
                
            }
            
        }
    }
}

protocol Key: UIView {
    func show()
    func reset()
}

class WhiteKey: UIView, Key {
    
    let label = UILabel()
    let overlay = UIView()
    
    convenience init(name: String, color: UIColor = .systemGreen) {
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
        label.textColor = .black
        
        overlay.isHidden = true
        label.text = name
    }
    
    func show() {
        overlay.isHidden = false
    }
    
    func reset() {
        overlay.isHidden = true
    }
}

class BlackKey: UIView, Key {
    
    let label = UILabel()
    let overlay = UIView()
    
    convenience init(name: String, color: UIColor = .systemGreen) {
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
        label.text = name
    }
    
    func show() {
        overlay.isHidden = false
    }
    
    func reset() {
        overlay.isHidden = true
    }
}

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
