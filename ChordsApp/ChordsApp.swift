//
//  App.swift
//  ChordsApp
//
//  Created by Sacha DSO on 07/11/2021.
//  Copyright © 2021 sachadso. All rights reserved.
//

import Foundation
import SwiftUI

struct ChordsApp: View {
    
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
            TextField("Cdim7", text: $viewModel.text)
                .foregroundColor(.white)
                .font(.system(size: 60, weight: .bold))
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                if viewModel.chord != nil {
                    Button(action: viewModel.invert) {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            Spacer()
            KeyBoard(chord: viewModel.visualChord)
                .frame(height: 300)
                .onTapGesture {
                    viewModel.play()
                }
            Spacer()
        }.background(Color.black.ignoresSafeArea())
    }
}
