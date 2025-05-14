//
//  VibrationResponseStore.swift.swift
//  HaptonsDesigner
//
//  Created by Manon Hardy on 07/05/2025.
//

import Foundation

class VibrationResponseStore: ObservableObject {
    @Published var responses: [String: String] = [:]
}
