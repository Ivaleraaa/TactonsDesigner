import SwiftUI

struct ContentView: View {
    @StateObject var store = VibrationResponseStore()
    let haptics = HapticManager()

    var body: some View {
        
        NavigationStack {
            VStack(spacing: 30) {
                Text("Tests Haptiques").font(.largeTitle)
                ScrollView {
                    VStack(spacing: 20) {
                        
                        NavigationLink("Test 1 : vibration forte") {
                            VibrationTestView(
                                vibrationID: "test1",
                                label: "Vibration forte",
                                vibrationAction: { haptics.playStrongContinuousVibration() },
                                store: store
                            )
                        }
                        
                        NavigationLink("Test 2 : vibration croissante") {
                            VibrationTestView(
                                vibrationID: "test2",
                                label: "Vibration croissante",
                                vibrationAction: { haptics.playRisingIntensityVibration(duration: 1.0) },
                                store: store
                            )
                        }
                        
                        NavigationLink("Test 3") {
                            VibrationTestView(
                                vibrationID: "test3",
                                label: "Vibration 10 Hz",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.play_v_09_11_4_8(sharpness: 0.3)
                                    }
                                },
                                store: store
                            )
                        }
                        NavigationLink("Test 4 : Vibration d'urgence") {
                            VibrationTestView(
                                vibrationID: "test4",
                                label: "urgence",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.playUrgency(priority: 1)
                                    }
                                },
                                store: store
                            )
                        }
                        NavigationLink("Test 5 : Vibration d'urgence") {
                            VibrationTestView(
                                vibrationID: "test5",
                                label: "urgence2",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.playUrgency(priority: 2)
                                    }
                                },
                                store: store
                            )
                        }
                        NavigationLink("Test 6 : Vibration d'urgence") {
                            VibrationTestView(
                                vibrationID: "test6",
                                label: "urgence3",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.playUrgency(priority: 3)
                                    }
                                    
                                },
                                store: store
                            )
                        }
                        NavigationLink("Test 7") {
                            VibrationTestView(
                                vibrationID: "test7",
                                label: "v-09-10-3-56",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.play_v_09_10_3_56()
                                    }
                                    
                                },
                                store: store
                            )
                        }
                        NavigationLink("Test 8") {
                            VibrationTestView(
                                vibrationID: "test8",
                                label: "v_09_10_4_2",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.play_v_09_10_4_2()
                                    }
                                },
                                store: store
                            )
                        }
                        NavigationLink("Test 9") {
                            VibrationTestView(
                                vibrationID: "test9",
                                label: "v_09_11_3_4",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.playPattern_09_11_3_4_precise()
                                    }
                                },
                                store: store
                            )
                        }
                        NavigationLink("test 10") {
                            VibrationTestView(
                                vibrationID: "test10",
                                label: "v_10_23_1_16",
                                vibrationAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                        haptics.play_v_10_23_1_16()
                                    }
                                },
                                store: store
                            )
                        }
                        NavigationLink("test 11"){
                            VibrationTestView(
                                vibrationID: "test11",
                                label: "v_09_12_1_53",
                                vibrationAction:{
                                    haptics.play_v_09_12_1_53()
                                },
                                store: store
                            )
                        }
                        NavigationLink("test 12"){
                            VibrationTestView(
                                vibrationID: "test12",
                                label: "v_09_10_12_2",
                                vibrationAction: {haptics.play_v_09_10_12_2()},
                                store: store)
                        }
                        NavigationLink("test 13"){
                            VibrationTestView(
                                vibrationID: "test13",
                                label: "v_10_18_11_11",
                                vibrationAction: {
                                    haptics.play_v_10_18_11_11()
                                },
                                store: store)
                        }
                    }
                }
                Divider()

                Text("Réponses enregistrées :")
                    .font(.headline)

                List {
                    ForEach(store.responses.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Text("\(key) → \(value)")
                    }
                }.frame(height: 200)
            }
            .padding()
        }
    }
}
