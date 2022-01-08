//
//  KeyboardPortion.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import SwiftUI
import Chords

//  heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.88, constant: 0).isActive = true

struct KeyboardPortion: View {
    
    let cNote: MIDINote
    let chord: VisualChord?

    private var selectedNotes: [MIDINote] {
        return chord?.midiNotes ?? []
    }

    init(cNote: MIDINote, chord: VisualChord?) {
        self.cNote = cNote
        self.chord = chord
        processChord()
    }

    mutating func processChord() {
        var notes = chord?.midiNotes
        notes?.enumerated().forEach { index, note in
            let interval = chord?.chord?.intervals[index]

            switch note {
            case cNote:
                cHighlighted = true
                cInterval = interval?.sign
            case cNote + 1:
                cSharpHighlighted = true
                cSharpInterval = interval?.sign
            case cNote + 2:
                dHighlighted = true
                dInterval = interval?.sign
            case cNote + 3:
                dSharpHighlighted = true
                dSharpInterval = interval?.sign
            case cNote + 4:
                eHighlighted = true
                eInterval = interval?.sign
            case cNote + 5:
                fHighlighted = true
                fInterval = interval?.sign
            case cNote + 6:
                fSharpHighlighted = true
                fSharpInterval = interval?.sign
            case cNote + 7:
                gHighlighted = true
                gInterval = interval?.sign
            case cNote + 8:
                gSharpHighlighted = true
                gSharpInterval = interval?.sign
            case cNote + 9:
                aHighlighted = true
                aInterval = interval?.sign
            case cNote + 10:
                aSharpHighlighted = true
                aSharpInterval = interval?.sign
            case cNote + 11:
                bHighlighted = true
                bInterval = interval?.sign
            default:
                ()
            }
        }
    }

    private var cHighlighted = false
    private var cInterval: String? = nil

    private var cSharpHighlighted = false
    private var cSharpInterval: String? = nil

    private var dHighlighted = false
    private var dInterval: String? = nil

    private var dSharpHighlighted = false
    private var dSharpInterval: String? = nil

    private var eHighlighted = false
    private var eInterval: String? = nil

    private var fHighlighted = false
    private var fInterval: String? = nil

    private var fSharpHighlighted = false
    private var fSharpInterval: String? = nil

    private var gHighlighted = false
    private var gInterval: String? = nil

    private var gSharpHighlighted = false
    private var gSharpInterval: String? = nil

    private var aHighlighted = false
    private var aInterval: String? = nil

    private var aSharpHighlighted = false
    private var aSharpInterval: String? = nil

    private var bHighlighted = false
    private var bInterval: String? = nil
    
    var body: some View {
        let height: CGFloat = 250
        let width: CGFloat = 50
        let blackHeight = height * 0.66
        let blackWidth = width * 0.6
        ZStack(alignment: Alignment.topLeading) {
            HStack(spacing: 1) {
                WhiteKey(name: "C", isHighlighted: cHighlighted, interval: cInterval)
                    .frame(width: width, height: height)
                WhiteKey(name: "D", isHighlighted: dHighlighted, interval: dInterval)
                    .frame(width: width, height: height)
                WhiteKey(name: "E", isHighlighted: eHighlighted, interval: eInterval)
                    .frame(width: width, height: height)
                WhiteKey(name: "F", isHighlighted: fHighlighted, interval: fInterval)
                    .frame(width: width, height: height)
                WhiteKey(name: "G", isHighlighted: gHighlighted, interval: gInterval)
                    .frame(width: width, height: height)
                WhiteKey(name: "A", isHighlighted: aHighlighted, interval: aInterval)
                    .frame(width: width, height: height)
                WhiteKey(name: "B", isHighlighted: bHighlighted, interval: bInterval)
                    .frame(width: width, height: height)
            }
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    BlackKey(name: "C♯", isHighlighted: cSharpHighlighted, interval: cSharpInterval)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                        .frame(width: width - blackWidth)
                    BlackKey(name: "D♯", isHighlighted: dSharpHighlighted, interval: dSharpInterval)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                }.frame(width: width * 3)
                HStack(spacing: 0) {
                    Spacer()
                    BlackKey(name: "F♯", isHighlighted: fSharpHighlighted, interval: fSharpInterval)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                        .frame(width: width - blackWidth)
                    BlackKey(name: "G♯", isHighlighted: gSharpHighlighted, interval: gSharpInterval)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                        .frame(width: width - blackWidth)
                    BlackKey(name: "A♯", isHighlighted: aSharpHighlighted, interval: aSharpInterval)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                }
            }
            Rectangle()
                .frame(height: 8)
                .foregroundColor(Color.black)
        }
        .background(Color.black)
        .frame(height: 400)
    }
}

struct KeyboardPortionUI_Preview: PreviewProvider {
    static var previews: some View {
        
        KeyboardPortion(cNote: 60, chord: nil)
            .previewLayout(.sizeThatFits)
        
    }
}


extension Interval {

    var sign: String {
        switch self {
        case .first:
            return "R"
        case .secondMinor:
            return "♭2"
        case .secondMajor:
            return "2"
        case .minorThird:
            return "♭3"
        case .majorThird:
            return "3"
        case .perfectfourth:
            return "4"
        case .tritone:
            return "♭5"
        case .perfectFifth:
            return "5"
        case .sixthMinor:
            return "♯5"
        case .sixthMajor:
            return "6"
        case .seventhMinor:
            return "♭7"
        case .seventhMajor:
            return "7"
        case .octave:
            return "8"
        case .ninthMinor:
            return "♭9"
        case .ninthMajor:
            return "9"
        }
    }

}
