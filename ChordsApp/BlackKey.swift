//
//  BlackKey.swift
//  ChordsApp
//
//  Created by Sacha on 05/11/2021.
//  Copyright © 2021 sachadso. All rights reserved.
//

import SwiftUI

struct BlackKey: View {

    let name: String
    let isHighlighted: Bool
    let height: CGFloat = 300
    let interval: String?

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isHighlighted ? Color(UIColor(named: "keyGreen")!) : .black)
                .cornerRadius(10)
            VStack {
                Spacer()
                if let interval = interval {
                    Text(interval)
                        .minimumScaleFactor(0.1)
                        .padding(5)
                        .background(Circle().foregroundColor(.red))
                }
                Text(name)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct BlackKey_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BlackKey(name: "G", isHighlighted: false, interval: nil)
            BlackKey(name: "D", isHighlighted: true, interval: nil)
        }
    }
}
