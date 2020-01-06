//
//  Keyboard.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import UIKit
import Stevia

class Keyboard: UIView {
    
    let keyboardPortion = KeyboardPortion()
    let keyboardPortion2 = KeyboardPortion()
    let keyboardFrame = UIView()
    let scrollView = UIScrollView()
    
    convenience init() {
        self.init(frame: .zero)
        
        // iPad layout
        if UIDevice.current.userInterfaceIdiom == .pad {
            sv(
                keyboardPortion,
                keyboardPortion2,
                keyboardFrame
            )
        
            |keyboardFrame.top(0).height(10)|
            
            |-20-keyboardPortion-(-1)-keyboardPortion2-20-|
            keyboardPortion.fillVertically()
            keyboardPortion2.fillVertically()
            
            
            keyboardPortion.Height == Height - 10
            keyboardPortion2.Height == Height - 10
        } else {
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
        }
        
        keyboardFrame.backgroundColor = .black
    }
    
    func resetDisplay() {
        keyboardPortion.notes.forEach { $0.reset() }
        keyboardPortion2.notes.forEach { $0.reset() }
    }
    
    func display(MIDINotes: [MIDINote]) {
        // C3 = 60, C4 = 73
        let keyboardNotes = keyboardPortion.notes + keyboardPortion2.notes
        for n in MIDINotes {
            let index = (Int(n) % 60)
            let key = keyboardNotes[index]
            key.show()
        }
        
        if let firstNote = keyboardPortion.notes.first(where: { !$0.overlay.isHidden }) {
            let offset = firstNote.frame.origin.x - 20
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
}


