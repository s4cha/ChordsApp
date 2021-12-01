//
//  App.swift
//  ChordsApp
//
//  Created by Sacha DSO on 07/11/2021.
//  Copyright © 2021 sachadso. All rights reserved.
//

import Foundation
import SwiftUI

struct App: View {
    
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Cdim7", text: $viewModel.text)
                .foregroundColor(.white)
                .font(.system(size: 60, weight: .bold))
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            Spacer()
            KeyBoard(selectedNotes: viewModel.MIDINotes)
                .frame(height: 300)
                .onTapGesture {
                    viewModel.play(MIDINotes: viewModel.MIDINotes)
                }
            Spacer()
        }.background(Color.black.ignoresSafeArea())
    }
}
