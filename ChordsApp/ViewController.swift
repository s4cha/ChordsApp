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
import AudioKit
import AudioKitUI

typealias MIDINote = UInt8

class ViewController: UIViewController {
    
    let engine = ChordsEngine()
    let field = UITextField()
    let keyboard = Keyboard()
    let sampler = AKAppleSampler()
    var MIDINotes = [MIDINote]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        try? sampler.loadMelodicSoundFont("SalC5Light2", preset: 0)
        AudioKit.output = sampler
        try? AudioKit.start()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        
        let tapgr = UITapGestureRecognizer(target: self, action: #selector(tap))
        keyboard.addGestureRecognizer(tapgr)
        
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
            if #available(iOS 13.0, *) {
                f.placeholder = "Cdim7"
            } else {
                f.textColor = .white
                f.attributedPlaceholder = NSAttributedString(string: "Cdim7", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray
                ])
            }
        }
    }
    
    @objc
    func tap() {
        print("tap")
        play(MIDINotes: MIDINotes)
    }
    
    @objc func textChanged() {
        updateChord(field.text!)
    }
    
    func updateChord(_ string: String) {
        keyboard.resetDisplay()
        if let chordFound = engine.chordFor(string: string) {
            MIDINotes = MIDINotesFor(chord: chordFound)
            keyboard.display(MIDINotes: MIDINotes)
        }
    }
    
    func MIDINotesFor(chord: Chord) -> [MIDINote] {
        // Display notes in order (not a inversion)
        // aka make sure notes are laid out from left to right.
        let kFirstCIndex: MIDINote = 60
        var midinotes = [MIDINote]()
        var previousNote: MIDINote? = nil
        chord.notes().forEach { note in
            let kbNoteType = keyboardNoteType(fromNote: note)
            if let index = KeyboardNoteType.allCases.firstIndex(of: kbNoteType) {
                var midiNote = kFirstCIndex + UInt8(index)
                if let previousNote = previousNote, midiNote < previousNote {
                    midiNote += 12
                }
                midinotes.append(midiNote)
                previousNote = midiNote
            }
        }
        return midinotes
    }
    
    func play(MIDINotes: [MIDINote]) {
        MIDINotes.forEach { n in
            try? sampler.play(noteNumber: n, velocity: 80, channel: 0)
        }
    }
}

