//
//  WhiteKey.swift
//  ChordsApp
//
//  Created by Sacha on 04/11/2021.
//  Copyright © 2021 sachadso. All rights reserved.
//

import SwiftUI

struct WhiteKey: View {

    let name: String
    let isHighlighted: Bool
    let height: CGFloat = 300

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isHighlighted ? Color(UIColor(named: "keyGreen")!) : .white)
                .cornerRadius(10)
            VStack {
                Spacer()
                Text(name)
                    .foregroundColor(isHighlighted ? .white : .black)
                    .padding()
                    .padding(.bottom, 20)
            }
        }
    }
}

struct SwiftUIViewTest_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            WhiteKey(name: "C", isHighlighted: false)
            WhiteKey(name: "A", isHighlighted: true)
        }.background(Color.black)
    }
}
