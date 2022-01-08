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
    let interval: String?

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isHighlighted ? Color(UIColor(named: "keyGreen")!) : .white)
                .cornerRadius(10)
            VStack {
                Spacer()
                if let interval = interval {
                    Text(interval)
                        .padding(5)
                        .background(Circle().foregroundColor(.red))
                }
                Text(name)
                    .foregroundColor(isHighlighted ? .white : .black)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct SwiftUIViewTest_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            WhiteKey(name: "C", isHighlighted: false, interval: nil)
            WhiteKey(name: "A", isHighlighted: true, interval: nil)
        }.background(Color.black)
    }
}
