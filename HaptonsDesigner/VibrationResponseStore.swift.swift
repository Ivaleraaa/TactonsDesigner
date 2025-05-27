//
//  VibrationResponseStore.swift
//  HaptonsDesigner
//
//  Created by Manon Hardy on 07/05/2025.
//

import Foundation

struct VibrationResponse: Codable {
    var type: String
    var source: String
    var priority: String
    var clickOrder: [String]
}

class VibrationResponseStore: ObservableObject {
    @Published var responses: [String: VibrationResponse] = [:] {
        didSet {
            saveResponses()
        }
    }

    private let storageKey = "VibrationResponses"

    init() {
        loadResponses()
    }

    private func saveResponses() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(responses) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadResponses() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? decoder.decode([String: VibrationResponse].self, from: data) {
            self.responses = decoded
        }
    }

    func reset() {
        responses = [:]
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
    
    func exportToFileURL() -> URL? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(responses) {
            let url = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("VibrationResponses.json")
            try? data.write(to: url)
            return url
        }
        return nil
    }

}
