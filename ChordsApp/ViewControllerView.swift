//
//  ViewControllerView.swift
//  ChordsApp
//
//  Created by Sacha on 06/01/2020.
//  Copyright © 2020 sachadso. All rights reserved.
//

import UIKit
import Stevia

class ViewControllerView: UIView {
    
    let field = UITextField()
    let keyboard = Keyboard()
    
    convenience init() {
        self.init(frame: .zero)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .black
        }
        
        sv (
            field,
            keyboard
        )
        
        field.Top == safeAreaLayoutGuide.Top + 20
        layout(
            |-40-field-40-|,
            40,
            |keyboard.height(300)|
        )
        
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
}
