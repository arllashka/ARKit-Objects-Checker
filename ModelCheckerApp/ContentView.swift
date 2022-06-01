//
//  ContentView.swift
//  ModelCheckerApp
//
//  Created by Arlan Kalin on 01.06.2022.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView : View {
    @State private var isPlacementEnabled = false
    @State private var selectedModel: ARModel?
    @State private var modelConfirmedForPlacement: ARModel?
    
    private var models: [ARModel] = {
        let filemanager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let files = try? filemanager.contentsOfDirectory(atPath: path) else { return [] }
        
        var availableModels: [ARModel] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = ARModel(modelName: modelName)
            availableModels.append(model)
        }
        
        return availableModels
    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: $modelConfirmedForPlacement)
            if isPlacementEnabled {
                ButtonsView(isPlacementEnabled: $isPlacementEnabled, selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
            } else {
                ModelCheckerView(isPlacementEnabled: $isPlacementEnabled, selectedModel: $selectedModel, models: models)
            }
        }
    }
}

// ["chair_swan", "fender_stratocaster", "toy_robot_vintage"]
struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: ARModel?
    
    func makeUIView(context: Context) -> ARView {
        let arView = FocusARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        arView.session.run(config)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = modelConfirmedForPlacement {
            if let modelEntity = model.modelEntity {
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                uiView.scene.addAnchor(anchorEntity)
            }
            DispatchQueue.main.async {
                modelConfirmedForPlacement = nil
            }
        } else {
            print("Error: UpdateView")
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
