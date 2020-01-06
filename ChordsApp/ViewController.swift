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

typealias MIDINote = UInt8

class ViewController: UIViewController {
    
    override func loadView() { view = v }
    
    let engine = ChordsEngine()
    let v = ViewControllerView()
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
        v.keyboard.addGestureRecognizer(tapgr)
        
        v.field.becomeFirstResponder()
        v.field.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc
    func tap() {
        play(MIDINotes: MIDINotes)
    }
    
    @objc func textChanged() {
        updateChord(v.field.text!)
    }
    
    func updateChord(_ string: String) {
        v.keyboard.resetDisplay()
        if let chordFound = engine.chordFor(string: string) {
            MIDINotes = MIDINotesFor(chord: chordFound)
            v.keyboard.display(MIDINotes: MIDINotes)
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

