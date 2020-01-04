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
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        } else {
            // Fallback on earlier versions
        }
        
        let tapgr = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapgr)
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .black
        }
        
        view.sv (
            field,
            keyboard
        )
        
        field.Top == view.safeAreaLayoutGuide.Top + 20
        view.layout(
            |-40-field-40-|,
            40,
            |keyboard.height(300)|
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
    
    @objc
    func tap() {
        field.resignFirstResponder()
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
    let keyboardPortion2 = KeyboardPortion()
    let keyboardFrame = UIView()
    let scrollView = UIScrollView()
    
    convenience init() {
        self.init(frame: .zero)
        
        sv(
            scrollView.sv (
                keyboardPortion,
                keyboardPortion2
            ),
            keyboardFrame
        )
    
        |keyboardFrame.top(0).height(10)|
        
        |-20-keyboardPortion-(-1)-keyboardPortion2-20-|
        keyboardPortion.fillVertically()
        keyboardPortion2.fillVertically()
        
        
        keyboardPortion.Height == Height - 10
        keyboardPortion2.Height == Height - 10
        
        scrollView.fillContainer()
        
        keyboardFrame.backgroundColor = .black
    }
    
    func resetDisplay() {
        keyboardPortion.notes.forEach { $0.reset() }
        keyboardPortion2.notes.forEach { $0.reset() }
    }
    
    func display(chord: Chord) {
        
        // C chord: CEG -> KeyboardChord -> C3E3G3
        // F chord: FAC -> KeyboardChord -> F3A3C4
        
        // Display notes in order (not a inversion)
        // aka make sure notes are laid out from left to right.
        var currentKeyboardPortion: KeyboardPortion = keyboardPortion
        var previousNote: Note? = nil
        
        chord.notes().forEach { note in
            if let previousNote = previousNote {
                let previouskbNoteType = keyboardNoteType(fromNote: previousNote)
                let kbNoteType = keyboardNoteType(fromNote: note)
                if let index = KeyboardNoteType.allCases.firstIndex(of: kbNoteType),
                    let previousIndex = KeyboardNoteType.allCases.firstIndex(of: previouskbNoteType) {
                    if index < previousIndex {
                        currentKeyboardPortion = keyboardPortion2
                    }
                }
            }
            
            switch note {
            case C:
                currentKeyboardPortion.C.show()
            case Csharp:
                currentKeyboardPortion.Csharp.show()
            case D:
                currentKeyboardPortion.D.show()
            case Dsharp:
                currentKeyboardPortion.Dsharp.show()
            case E:
                currentKeyboardPortion.E.show()
            case F:
                currentKeyboardPortion.F.show()
            case Fsharp:
                currentKeyboardPortion.Fsharp.show()
            case G:
                currentKeyboardPortion.G.show()
            case Gsharp:
                currentKeyboardPortion.Gsharp.show()
            case A:
                currentKeyboardPortion.A.show()
            case Asharp:
                currentKeyboardPortion.Asharp.show()
            case B:
                currentKeyboardPortion.B.show()
            default: ()
                
            }
            previousNote = note
        }
        
        
        if let firstNote = keyboardPortion.notes.first(where: { !$0.overlay.isHidden }) {
            let offset = firstNote.frame.origin.x - 20
            print(offset)
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
}

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
