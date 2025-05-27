import SwiftUI



struct ContentView: View {
    @StateObject var store = VibrationResponseStore()
    @State private var exportFileURL: URL?
    @State private var selectedTestID: String? = nil
    @State private var showResetConfirmation = false

    let haptics = HapticManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                SwiftUICore.Text("Tests Haptiques").font(.largeTitle)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Tous tes tests (inchangés)
                        testNavigationLinks()
                    }
                }
                
                Divider()
                
                SwiftUICore.Text("Réponses enregistrées :")
                    .font(.headline)
                
                List {
                    ForEach(store.responses.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        VStack(alignment: .leading) {
                            Text("🔹 \(key)").bold()
                            Text("Type : \(value.type)")
                            Text("Source : \(value.source)")
                            Text("Priorité : \(value.priority)")
                            Text("Ordre : \(value.clickOrder.joined(separator: " > "))")
                        }
                    }
                }.frame(height: 200)
                
                Divider()
                
                Button("💾 Générer fichier JSON") {
                    exportFileURL = store.exportToFileURL()
                }
                if showResetConfirmation {
                    VStack(spacing: 20) {
                        Text("Êtes-vous sûr·e de vouloir effacer toutes les réponses ?")
                            .font(.headline)
                            .multilineTextAlignment(.center)

                        HStack {
                            Button("Annuler") {
                                showResetConfirmation = false
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)

                            Button("Oui, effacer") {
                                store.reset()
                                showResetConfirmation = false
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                } else {
                    Button("🗑️ Réinitialiser les réponses") {
                        showResetConfirmation = true
                    }
                    .foregroundColor(.red)
                }


                
                if let fileURL = exportFileURL {
                    ShareLink("📤 Exporter via AirDrop / Mail / Fichiers", item: fileURL)
                        .padding(.top, 5)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func testNavigationLinks() -> some View {
        Group {
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test1",
                    label: "StrongContinuousVibration",
                    vibrationAction: { haptics.playStrongContinuousVibration() },
                    store: store
                ),
                label: {
                    Text("Test 1")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test1" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test1" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test2",
                    label: "RisingIntensityVibration",
                    vibrationAction: { haptics.playRisingIntensityVibration(duration: 1.0) },
                    store: store
                ),
                label: {
                    Text("Test 2")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test2" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test2" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test3",
                    label: "v_09_11_4_8",
                    vibrationAction: { haptics.play_v_09_11_4_8(sharpness: 0.3) },
                    store: store
                ),
                label: {
                    Text("Test 3")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test3" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test3" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test4",
                    label: "v_u_27",
                    vibrationAction: { haptics.playUrgency(priority: 1) },
                    store: store
                ),
                label: {
                    Text("Test 4")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test4" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test4" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test5",
                    label: "v_u_28",
                    vibrationAction: { haptics.playUrgency(priority: 2) },
                    store: store
                ),
                label: {
                    Text("Test 5")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test5" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test5" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test6",
                    label: "v_u_29",
                    vibrationAction: { haptics.playUrgency(priority: 3) },
                    store: store
                ),
                label: {
                    Text("Test 6")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test6" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test6" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test7",
                    label: "v-09-10-3-56",
                    vibrationAction: { haptics.play_v_09_10_3_56() },
                    store: store
                ),
                label: {
                    Text("Test 7")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test7" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test7" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test8",
                    label: "v_09_10_4_2",
                    vibrationAction: { haptics.play_v_09_10_4_2() },
                    store: store
                ),
                label: {
                    Text("Test 8")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test8" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test8" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test9",
                    label: "v_09_11_3_4",
                    vibrationAction: { haptics.playPattern_09_11_3_4_precise() },
                    store: store
                ),
                label: {
                    Text("Test 9")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test9" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test9" })
            
            NavigationLink(
                destination: VibrationTestView(
                    vibrationID: "test10",
                    label: "v_10_23_1_16",
                    vibrationAction: { haptics.play_v_10_23_1_16() },
                    store: store
                ),
                label: {
                    Text("Test 10")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTestID == "test10" ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                }
            ).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test10" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test11", label: "v_09_12_1_53", vibrationAction:{ haptics.play_v_09_12_1_53() }, store: store), label: {
                Text("Test 11")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test11" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test11" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test12", label: "v_09_10_12_2", vibrationAction:{ haptics.play_v_09_10_12_2() }, store: store), label: {
                Text("Test 12")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test12" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test12" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test13", label: "v_10_18_11_11", vibrationAction:{ haptics.play_v_10_18_11_11() }, store: store), label: {
                Text("Test 13")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test13" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test13" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test14", label: "v_les_tzars", vibrationAction:{ haptics.play_les_tzars() }, store: store), label: {
                Text("Test 14")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test14" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test14" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test15", label: "v_la_main_verte", vibrationAction:{ haptics.play_la_main_verte() }, store: store), label: {
                Text("Test 15")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test15" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test15" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test16", label: "v_miss_paramount", vibrationAction:{ haptics.play_miss_paramout() }, store: store), label: {
                Text("Test 16")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test16" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test16" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test17", label: "v_lapologie", vibrationAction:{ haptics.play_l_apologie() }, store: store), label: {
                Text("Test 17")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test17" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test17" })
            
            NavigationLink(destination: VibrationTestView(vibrationID: "test18", label: "v_ciel", vibrationAction:{ haptics.playRisingSharpnessVibration(duration: 1.0, intensity: 1.0, sharpnessMin: 1.0, sharpnessMax: 0.1) }, store: store), label: {
                Text("Test 18")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTestID == "test18" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }).simultaneousGesture(TapGesture().onEnded { selectedTestID = "test18" })
        }
    }
}
