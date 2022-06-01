//
//  ButtonsView.swift
//  ModelCheckerApp
//
//  Created by Arlan Kalin on 01.06.2022.
//

import SwiftUI

struct ButtonsView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: ARModel?
    @Binding var modelConfirmedForPlacement: ARModel?
    
    var body: some View {
        HStack {
            Button(action: {
                resetParameters()
            }) {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            
            Button(action: {
                modelConfirmedForPlacement = selectedModel
                resetParameters()
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    
    private func resetParameters() {
        isPlacementEnabled = false
        selectedModel = nil
    }
}
