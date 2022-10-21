//
//  AppViewModel.swift
//  ChordsApp
//
//  Created by Sacha DSO on 07/11/2021.
//  Copyright © 2021 sachadso. All rights reserved.
//

import Foundation
import Chords
import AudioKit
import Combine

typealias MIDINote = UInt8
let kStartingCMIDINote: UInt8 = 60


struct VisualChord {

    let chord: Chord?
    let midiNotes: [MIDINote]

    init(chord: Chord?) {
        self.chord = chord
        if let chord = chord {
            midiNotes = VisualChord.MIDINotesFor(chord: chord)
        } else {
            midiNotes = []
        }
    }

    static func MIDINotesFor(chord: Chord) -> [MIDINote] {
        // Display notes in order (not a inversion)
        // aka make sure notes are laid out from left to right.
        var referenceCIndex: MIDINote = kStartingCMIDINote
        var midinotes = [MIDINote]()
        var previousNote: MIDINote? = nil
        chord.notes().forEach { note in
            let kbNoteType = keyboardNoteType(fromNote: note)
            if let index = KeyboardNoteType.allCases.firstIndex(of: kbNoteType) {
                var midiNote = referenceCIndex + UInt8(index)
                if let previousNote = previousNote, midiNote < previousNote {
                    midiNote += 12
                    referenceCIndex += 12
                }
                midinotes.append(midiNote)
                previousNote = midiNote
            }
        }
        return midinotes
    }
}

final class AppViewModel: ObservableObject {

    @Published var chord: Chord? {
        didSet {
            play()
        }
    }
    @Published var text: String = ""

    var visualChord: VisualChord? {
        VisualChord(chord: chord)
    }
    
    private let engine = ChordsEngine()
    private let sampler = AppleSampler()
    private let audioEngine = AudioEngine()
    private var cancellables = Set<AnyCancellable>()

    init() {
        try? sampler.loadMelodicSoundFont("Giga Piano", preset: 0)
        audioEngine.output = sampler
        try? audioEngine.start()
        
        $text
            .sink(receiveValue: self.updateChord)
            .store(in: &cancellables)
    }
    
    func updateChord(_ string: String) {
        let newChord = engine.chordFor(string: string)
        if chord?.notes() != newChord?.notes() {
            chord = newChord
        }
    }
    
    public func play() {
        visualChord?.midiNotes.forEach { n in
            sampler.play(noteNumber: n, velocity: 80, channel: 0)
        }
    }

    public func invert() {
        chord = chord?.nextInversion()
    }
}
