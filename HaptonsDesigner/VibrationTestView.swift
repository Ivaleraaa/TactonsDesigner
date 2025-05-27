//
//  VibrationTestView.swift
//  HaptonsDesigner
//
//  Created by Manon Hardy on 07/05/2025.
//

import SwiftUI

struct VibrationTestView: View {
    let vibrationID: String
    let label: String
    let vibrationAction: () -> Void
    @ObservedObject var store: VibrationResponseStore
    @Environment(\.dismiss) var dismiss

    @State private var selectedType: String? = nil
    @State private var selectedSource: String? = nil
    @State private var selectedPriority: String? = nil
    @State private var clickHistory: [(group: String, label: String)] = []

    var body: some View {
        VStack(spacing: 30) {
            Text(label).font(.title2)

            Button("🔘 Ressentir") {
                vibrationAction()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text("À quoi vous fait-elle penser ?").font(.headline)

            // Groupe 1 : Type
            VStack(alignment: .leading) {
                Text("Type de notification").font(.subheadline)
                HStack {
                    ForEach(["Whatsapp", "SMS", "Réseau social"], id: \.self) { type in
                        ChoiceButton(label: type, isSelected: selectedType == type) {
                            selectedType = type
                            registerClick(group: "Type", label: type)
                        }
                    }
                }
            }

            // Groupe 2 : Source
            VStack(alignment: .leading) {
                Text("Provenance").font(.subheadline)
                HStack {
                    ForEach(["Groupe", "Personne Normale", "Famille"], id: \.self) { source in
                        ChoiceButton(label: source, isSelected: selectedSource == source) {
                            selectedSource = source
                            registerClick(group: "Source", label: source)
                        }
                    }
                }
            }

            // Groupe 3 : Priorité
            VStack(alignment: .leading) {
                Text("Priorité perçue").font(.subheadline)
                HStack {
                    ForEach(["Priorité faible", "Priorité moyenne", "Priorité élevée"], id: \.self) { priority in
                        ChoiceButton(label: priority, isSelected: selectedPriority == priority) {
                            selectedPriority = priority
                            registerClick(group: "Priorité", label: priority)
                        }
                    }
                }
            }

            if selectedType != nil && selectedSource != nil && selectedPriority != nil {
                Button("✅ Valider") {
                    store.responses[vibrationID] = VibrationResponse(
                        type: selectedType!,
                        source: selectedSource!,
                        priority: selectedPriority!,
                        clickOrder: clickHistory.map { $0.label }
                    )
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        dismiss()
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Test \(vibrationID)")
    }

    private func registerClick(group: String, label: String) {
        clickHistory.removeAll { $0.group == group }
        clickHistory.append((group, label))
    }
}

struct ChoiceButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(10)
        }
    }
}
