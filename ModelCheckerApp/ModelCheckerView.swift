//
//  ModelCheckerView.swift
//  ModelCheckerApp
//
//  Created by Arlan Kalin on 01.06.2022.
//

import SwiftUI

struct ModelCheckerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: ARModel?
    
    var models: [ARModel]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models.count) { index in
                    Button(action: {
                        selectedModel = models[index]
                        isPlacementEnabled = true
                    }) {
                        Image(uiImage: models[index].image).resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .buttonStyle(PlainButtonStyle())
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
    }
}
