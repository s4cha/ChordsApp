//
//  KeyboardPortion.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import SwiftUI

//  heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.88, constant: 0).isActive = true

struct KeyboardPortion: View {
    
    let cNote: MIDINote
    let selectedNotes: [MIDINote]
    
    var body: some View {
        let height: CGFloat = 250
        let width: CGFloat = 50
        let blackHeight = height * 0.66
        let blackWidth = width * 0.6
        ZStack(alignment: Alignment.topLeading) {
            HStack(spacing: 1) {
                WhiteKey(name: "C", isHighlighted: selectedNotes.contains(cNote))
                    .frame(width: width, height: height)
                WhiteKey(name: "D", isHighlighted: selectedNotes.contains(cNote + 2))
                    .frame(width: width, height: height)
                WhiteKey(name: "E", isHighlighted: selectedNotes.contains(cNote + 4))
                    .frame(width: width, height: height)
                WhiteKey(name: "F", isHighlighted: selectedNotes.contains(cNote + 6))
                    .frame(width: width, height: height)
                WhiteKey(name: "G", isHighlighted: selectedNotes.contains(cNote + 7))
                    .frame(width: width, height: height)
                WhiteKey(name: "A", isHighlighted: selectedNotes.contains(cNote + 9 ))
                    .frame(width: width, height: height)
                WhiteKey(name: "B", isHighlighted: selectedNotes.contains(cNote + 11))
                    .frame(width: width, height: height)
            }
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    BlackKey(name: "C#", isHighlighted: selectedNotes.contains(cNote + 1))
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                        .frame(width: width - blackWidth)
                    BlackKey(name: "D#", isHighlighted: selectedNotes.contains(cNote + 3))
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                }.frame(width: width * 3)
                HStack(spacing: 0) {
                    Spacer()
                    BlackKey(name: "F#", isHighlighted: selectedNotes.contains(cNote + 5))
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                        .frame(width: width - blackWidth)
                    BlackKey(name: "G#", isHighlighted: selectedNotes.contains(cNote + 8))
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer()
                        .frame(width: width - blackWidth)
                    BlackKey(name: "A#", isHighlighted: selectedNotes.contains(cNote + 10))
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
        
        KeyboardPortion(cNote: 60, selectedNotes: [])
            .previewLayout(.sizeThatFits)
        
    }
}
