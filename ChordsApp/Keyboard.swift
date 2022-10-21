//
//  Keyboard.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import SwiftUI

//v.field.becomeFirstResponder()
//v.field.addTarget(self, action: #selector(textChanged), for: .editingChanged)


struct KeyBoard: View {
    
    let chord: VisualChord?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 1) {
                KeyboardPortion(cNote: 60, chord: chord)
                KeyboardPortion(cNote: 72, chord: chord)
                KeyboardPortion(cNote: 84, chord: chord)
            }
        }
    }
}

// TODO scroll to selected notes
//if let firstNote = keyboardPortion.notes.first(where: { !$0.overlay.isHidden }) {
//    let offset = firstNote.frame.origin.x - 20
//    scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
//}

//    func display(MIDINotes: [MIDINote]) {
//        // C2 = 48,  C3 = 60, C4 = 72
//        let keyboardNotes = keyboardPortion.notes + keyboardPortion2.notes
//        for n in MIDINotes {
//            let index = (Int(n) % Int(kStartingCMIDINote))
//            let key = keyboardNotes[index]
//            key.show()
//        }
//
//
//    }

