//
//  ARModel.swift
//  ModelCheckerApp
//
//  Created by Arlan Kalin on 01.06.2022.
//

import UIKit
import RealityKit
import Combine

class ARModel {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName) ?? UIImage()
        let filename = modelName + ".usdz"
        cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: { loadCompletion in
            print("Error: Model")
        }, receiveValue: { modelEntity in
            self.modelEntity = modelEntity
        })
    }
}
