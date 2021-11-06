//
//  KeyboardPortion.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import UIKit
import Stevia

class KeyboardPortion2: UIView {

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


import SwiftUI
//
//class KeyboardPortionViewModel: ObservableObject {
//
//}

struct KeyboardPortion: View {

//    @StateObject var viewModel = KeyboardPortionViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            let height: CGFloat = 250
            let width: CGFloat = 50

            let blackHeight = height * 0.66
            let blackWidth = width * 0.6
            ZStack(alignment: Alignment.topLeading) {
                HStack(spacing: 1) {
                    WhiteKey(name: "C", isHighlighted: true)
                        .frame(width: width, height: height)
                    WhiteKey(name: "D", isHighlighted: false)
                        .frame(width: width, height: height)
                    WhiteKey(name: "E", isHighlighted: true)
                        .frame(width: width, height: height)
                    WhiteKey(name: "F", isHighlighted: false)
                        .frame(width: width, height: height)
                    WhiteKey(name: "G", isHighlighted: true)
                        .frame(width: width, height: height)
                    WhiteKey(name: "A", isHighlighted: false)
                        .frame(width: width, height: height)
                    WhiteKey(name: "B", isHighlighted: false)
                        .frame(width: width, height: height)
                }
                HStack {
                    Spacer().frame(width: 40)
                    BlackKey(name: "C#", isHighlighted: false)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer().frame(width:30)
                    BlackKey(name: "D#", isHighlighted: false)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer().frame(width:85)
                    BlackKey(name: "F#", isHighlighted: false)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer().frame(width:30)
                    BlackKey(name: "G#", isHighlighted: false)
                        .frame(width: blackWidth, height: blackHeight)
                    Spacer().frame(width:30)
                    BlackKey(name: "A#", isHighlighted: false)
                        .frame(width: blackWidth, height: blackHeight)
                }
            }
        }
        .background(Color.black)
        .frame(height: 400)
    }
}

struct KeyboardPortionUI_Preview: PreviewProvider {
    static var previews: some View {
        KeyboardPortion()
    }
}
