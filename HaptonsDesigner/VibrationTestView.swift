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

            Text("À quoi vous fait-elle penser ? ").font(.headline)

            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(["Whatsapp", "SMS", "Réseau social", "Groupe", "Personne Normale", "Famille", "Priorité faible", "Priorité moyenne", "Priorité élevée"], id: \.self) { response in
                    Button(response) {
                        store.responses[vibrationID] = response
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            dismiss()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Test \(vibrationID)")
    }
}
