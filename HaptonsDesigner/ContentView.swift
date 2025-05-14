import SwiftUI

struct ContentView: View {
    @StateObject var store = VibrationResponseStore()
    let haptics = HapticManager()

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Tests Haptiques").font(.largeTitle)

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

                NavigationLink("Test 3 : vibration répétée") {
                    VibrationTestView(
                        vibrationID: "test3",
                        label: "Vibration 10 Hz",
                        vibrationAction: {
                            haptics.playTransientPulse(frequencyHz: 10.0, durationSeconds: 2.0)
                        },
                        store: store
                    )
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
