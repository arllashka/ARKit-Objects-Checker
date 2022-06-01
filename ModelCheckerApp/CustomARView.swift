//
//  CustomARView.swift
//  ModelCheckerApp
//
//  Created by Arlan Kalin on 01.06.2022.
//

import RealityKit
import UIKit
import FocusEntity

class FocusARView: ARView {
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        self.focusEntity = FocusEntity(on: self, focus: .classic)
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
