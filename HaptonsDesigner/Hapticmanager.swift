//
//  Hapticmanager.swift
//  HaptonsDesigner
//
//  Created by Manon Hardy on 07/05/2025.
//

import Foundation
import CoreHaptics

class HapticManager {
    private var engine: CHHapticEngine?
    
    init() {
        prepareEngine()
    }
    
    private func prepareEngine() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Erreur moteur haptique : \(error)")
        }
    }
    func playParametrableVibration(duration: TimeInterval, intensity: Float, sharpness: Float) {
        guard let engine = engine else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensity, sharpness],
            relativeTime: 0.0,
            duration: duration
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur de vibration continue : \(error)")
        }
    }
    
    
    
    
    /// vibration répétée
    func playTransientPulse(frequencyHz: Double, durationSeconds: Double) {
        guard let engine = engine else { return }
        
        let interval = 1.0 / frequencyHz
        let numberOfPulses = Int(durationSeconds / interval)
        
        var events = [CHHapticEvent]()
        
        for i in 0..<numberOfPulses {
            let time = Double(i) * interval
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            
            let event = CHHapticEvent(eventType: .hapticTransient,
                                      parameters: [intensity, sharpness],
                                      relativeTime: time)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur de pattern haptique : \(error)")
        }
    }
    func playStrongContinuousVibration(duration: TimeInterval = 2.0) {
        guard let engine = engine else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensity, sharpness],
            relativeTime: 0.0,
            duration: duration
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur de vibration continue : \(error)")
        }
    }
    func playSmallVibration(duration: TimeInterval = 2.0) {
        guard let engine = engine else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensity, sharpness],
            relativeTime: 0.0,
            duration: duration
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur de vibration continue : \(error)")
        }
    }
    /// Vibration avec intensité croissante sur 2 secondes
    /// Joue une vibration continue dont l'intensité augmente progressivement sur toute la durée.
    func playRisingIntensityVibration(duration: TimeInterval = 2.0) {
        guard let engine = engine else { return }
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [],
            relativeTime: 0,
            duration: duration
        )
        
        let intensityCurve = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [
                CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 0.1),
                CHHapticParameterCurve.ControlPoint(relativeTime: duration, value: 1.0)
            ],
            relativeTime: 0
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern haptique : \(error)")
        }
    }
    
    // sharpness parametrable
    func playRisingSharpnessVibration(
        duration: TimeInterval = 2.0,
        intensity: Float = 0.5,
        sharpnessMin: Float = 0.1,
        sharpnessMax: Float = 1.0
    ) {
        guard let engine = engine else { return }
        
        // Événement haptique continu
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            ],
            relativeTime: 0,
            duration: duration
        )
        
        // Courbe de sharpness montante
        let sharpnessCurve = CHHapticParameterCurve(
            parameterID: .hapticSharpnessControl,
            controlPoints: [
                CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: sharpnessMin),
                CHHapticParameterCurve.ControlPoint(relativeTime: duration, value: sharpnessMax)
            ],
            relativeTime: 0
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [sharpnessCurve])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern haptique : \(error)")
        }
    }
    
    
    
    
    func playUrgency(priority: Int){
        guard let engine = engine else { return }
        var priorityintensity : Double = 0
        var duration : Double = 0
        
        if priority == 1 {
            priorityintensity = 0.5
            duration = 0.3
        }
        else if priority == 2 {
            priorityintensity = 0.6
            duration = 0.6
        }
        else {
            priorityintensity = 1.0
            duration = 1.0
        }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(priorityintensity))
        
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensity, sharpness],
            relativeTime: 0.0,
            duration: duration,
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur de vibration continue : \(error)")
        }
    }
    
    func playDecreasingIntensityVibration(duration: TimeInterval = 2.0, sharpness: Float) {
        guard let engine = engine else { return }
        
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensityParameter, sharpnessParameter],
            relativeTime: 0,
            duration: duration
        )
        
        let intensityCurve = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [
                .init(relativeTime: 0, value: 1.0),
                .init(relativeTime: duration, value: 0.1)
            ],
            relativeTime: 0
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern haptique : \(error)")
        }
    }
    
    
    func play_v_09_11_4_8(pause: TimeInterval = 0.2, repetitions: Int = 4, duration: TimeInterval = 0.3, sharpness: Float) {
        for i in 0..<repetitions {
            let delay = Double(i) * (duration + pause)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.playDecreasingIntensityVibration(duration: duration, sharpness: sharpness)
            }
        }
    }
    
    
    func play_v_09_10_3_56() {
        guard let engine = engine else { return }
        
        var events: [CHHapticEvent] = []
        let _: TimeInterval = 0.03 // Durée d’un pulse
        let pulseCount = 10                   // 10 pulses avant et après la pause
        let spacing: TimeInterval = 0.06      // Intervalle entre les pulses
        let pauseBetweenGroups: TimeInterval = 0.5 // Pause centrale
        let sharpness: Float = 0.9
        let intensity: Float = 1.0
        
        // Première séquence de pulses
        for i in 0..<pulseCount {
            let relativeTime = Double(i) * spacing
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness),
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
                ],
                relativeTime: relativeTime
            )
            events.append(event)
        }
        
        // Deuxième séquence de pulses (après la pause)
        for i in 0..<pulseCount {
            let relativeTime = Double(i) * spacing + (Double(pulseCount) * spacing) + pauseBetweenGroups
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness),
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
                ],
                relativeTime: relativeTime
            )
            events.append(event)
        }
        
        // Création et lecture du pattern
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern haptique : \(error)")
        }
    }
    
    func play_v_09_10_4_2() {
        guard let engine = engine else { return }
        
        var events: [CHHapticEvent] = []
        var parameterCurves: [CHHapticParameterCurve] = []
        
        let pulseDuration: TimeInterval = 0.12
        let spacing: TimeInterval = 0.05
        let baseTime: TimeInterval = 0.0
        
        // Alternance intensité / sharpness : petit / grand / ...
        let pattern: [(Float, Float)] = [
            (0.3, 0.4), // petit
            (1.0, 0.9), // grand
            (0.3, 0.4),
            (1.0, 0.9),
            (0.3, 0.4),
            (1.0, 0.9),
            (0.3, 0.4)
        ]
        
        for (index, (maxIntensity, sharpness)) in pattern.enumerated() {
            let startTime = baseTime + Double(index) * (pulseDuration + spacing)
            
            // Événement continu avec sharpness fixe
            let event = CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
                ],
                relativeTime: startTime,
                duration: pulseDuration
            )
            events.append(event)
            
            // Courbe d’intensité qui monte puis descend sur un pic bref
            let curve = CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    .init(relativeTime: startTime, value: 0.0),
                    .init(relativeTime: startTime + pulseDuration / 2, value: maxIntensity),
                    .init(relativeTime: startTime + pulseDuration, value: 0.0)
                ],
                relativeTime: 0
            )
            parameterCurves.append(curve)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: parameterCurves)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern haptique : \(error)")
        }
    }
    
    
    
    func playPattern_09_11_3_4_precise() {
        guard let engine = engine else { return }
        
        var events: [CHHapticEvent] = []
        var parameterCurves: [CHHapticParameterCurve] = []
        
        var timeCursor: TimeInterval = 0.0
        
        // === 1. Vibration forte et stable ===
        let firstDuration: TimeInterval = 0.4
        let event1 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                .init(parameterID: .hapticIntensity, value: 1.0),
                .init(parameterID: .hapticSharpness, value: 0.6)
            ],
            relativeTime: timeCursor,
            duration: firstDuration
        )
        events.append(event1)
        timeCursor += firstDuration
        
        // === 2. Vibration moyenne avec variation de sharpness ===
        let secondDuration: TimeInterval = 0.4
        let event2 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                .init(parameterID: .hapticIntensity, value: 0.5)
            ],
            relativeTime: timeCursor,
            duration: secondDuration
        )
        events.append(event2)
        
        let sharpnessCurve2 = CHHapticParameterCurve(
            parameterID: .hapticSharpnessControl,
            controlPoints: [
                .init(relativeTime: timeCursor, value: 0.3),
                .init(relativeTime: timeCursor + secondDuration / 2, value: 0.8),
                .init(relativeTime: timeCursor + secondDuration, value: 0.3)
            ],
            relativeTime: 0
        )
        parameterCurves.append(sharpnessCurve2)
        timeCursor += secondDuration
        
        // === 3. Triangle : intensité ET sharpness modulées ===
        let thirdDuration: TimeInterval = 0.7
        let event3 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [],
            relativeTime: timeCursor,
            duration: thirdDuration
        )
        events.append(event3)
        
        let intensityCurve3 = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [
                .init(relativeTime: timeCursor, value: 0.0),
                .init(relativeTime: timeCursor + thirdDuration / 2, value: 1.0),
                .init(relativeTime: timeCursor + thirdDuration, value: 0.0)
            ],
            relativeTime: 0
        )
        
        let sharpnessCurve3 = CHHapticParameterCurve(
            parameterID: .hapticSharpnessControl,
            controlPoints: [
                .init(relativeTime: timeCursor, value: 0.3),
                .init(relativeTime: timeCursor + thirdDuration / 2, value: 0.8),
                .init(relativeTime: timeCursor + thirdDuration, value: 0.3)
            ],
            relativeTime: 0
        )
        
        parameterCurves.append(intensityCurve3)
        parameterCurves.append(sharpnessCurve3)
        
        // === Création et lecture du pattern ===
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: parameterCurves)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern détaillé : \(error)")
        }
    }
    
    // tuu tii tuu
    func play_v_10_23_1_16(){
        let duration = 1.1 / 3
        
        self.playParametrableVibration(duration: duration, intensity: 1.0, sharpness: 0.2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.playParametrableVibration(duration: duration, intensity: 1.0, sharpness: 0.7)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.playParametrableVibration(duration: duration, intensity: 1.0, sharpness: 0.2)
            }
        }
    }
    // tu tud    tu tud    tu tud
    func play_v_09_12_1_53() {
        let pulseDuration: TimeInterval = 0.06
        let shortGap: TimeInterval = 0.04 // entre les 2 pulses d’une paire
        let longGap: TimeInterval = 0.3   // entre les paires
        
        let timestamps: [TimeInterval] = [
            0.0,
            pulseDuration + shortGap,
            pulseDuration * 2 + shortGap + longGap,
            
            (pulseDuration * 3 + shortGap * 2 + longGap),
            (pulseDuration * 4 + shortGap * 2 + longGap * 2),
            
            (pulseDuration * 5 + shortGap * 3 + longGap * 2),
            (pulseDuration * 6 + shortGap * 3 + longGap * 3)
        ]
        
        for (i, time) in timestamps.prefix(6).enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.playParametrableVibration(duration: pulseDuration, intensity: 1.0, sharpness: 0.4)
            }
        }
    }
    
    func play_v_09_10_12_2() {
        guard let engine = engine else { return }
        
        var events: [CHHapticEvent] = []
        var curves: [CHHapticParameterCurve] = []
        
        let pulseDuration: TimeInterval = 0.6
        let pause: TimeInterval = 0.125
        let count = 4
        let totalDuration = TimeInterval(count) * (pulseDuration + pause)
        
        for i in 0..<count {
            let startTime = Double(i) * (pulseDuration + pause)
            
            // Haptic event
            let event = CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [],
                relativeTime: startTime,
                duration: pulseDuration
            )
            events.append(event)
            
            // Courbe d'intensité (triangle fluide)
            let intensityCurve = CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    .init(relativeTime: startTime, value: 0.0),
                    .init(relativeTime: startTime + pulseDuration / 2, value: 1.0),
                    .init(relativeTime: startTime + pulseDuration, value: 0.0)
                ],
                relativeTime: 0
            )
            curves.append(intensityCurve)
            
            // Courbe de sharpness douce
            let sharpnessCurve = CHHapticParameterCurve(
                parameterID: .hapticSharpnessControl,
                controlPoints: [
                    .init(relativeTime: startTime, value: 0.2),
                    .init(relativeTime: startTime + pulseDuration / 2, value: 0.5),
                    .init(relativeTime: startTime + pulseDuration, value: 0.2)
                ],
                relativeTime: 0
            )
            curves.append(sharpnessCurve)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: curves)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Erreur lors de la lecture du pattern v-09-10-12-2 : \(error)")
        }
    }
    
    func play_v_10_18_11_11(){
        let duration = 1.1 / 3
        
        self.playParametrableVibration(duration: duration, intensity: 1.0, sharpness: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.playParametrableVibration(duration: duration, intensity: 1.0, sharpness: 0.5)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.playParametrableVibration(duration: duration, intensity: 1.0, sharpness: 0.2)
            }
        }
    }
    func play_les_tzars(){
        self.playParametrableVibration(duration: 0.5, intensity: 0.8, sharpness: 0.75)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.playParametrableVibration(duration: 0.5, intensity: 0.8, sharpness: 0.25)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.playParametrableVibration(duration: 0.25, intensity: 0.8, sharpness: 0.50)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.playParametrableVibration(duration: 0.25, intensity: 0.8, sharpness: 0.75)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.playParametrableVibration(duration: 0.5, intensity: 0.8, sharpness: 1.0)
                    }
                }
            }
        }
    }
    
    func play_la_main_verte(){
        self.playRisingSharpnessVibration(duration: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.62) {
            self.playParametrableVibration(duration: 0.12, intensity: 1, sharpness: 0.75)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                self.playParametrableVibration(duration: 0.25, intensity: 1, sharpness: 1)
            }
        }
    }
    func play_miss_paramout(){
        // deux croches deux croches noire
        self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
            self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 1.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
                self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 0.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
                    self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 1.0)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.playParametrableVibration(duration: 0.5, intensity: 0.7, sharpness: 0.5)
                    }
                }
            }
        }
    }
    func play_l_apologie(){
        for i in 0..<5 {
            let delay = DispatchTime.now() + 0.15 * Double(i)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.playParametrableVibration(
                    duration: 0.125,
                    intensity: 0.7,
                    sharpness: 0.5
                )
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
                self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 1.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                    self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 1.0)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                        self.playRisingSharpnessVibration(duration: 0.25, intensity: 0.7, sharpnessMin: 1.0, sharpnessMax: 0.2)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.40){
                            self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 0.2)
                        }
                        
                    }
                }
            }
        }
    }
    // 2 secondes
    func play_stay_with_me(){
        self.playParametrableVibration(duration: 0.25, intensity: 0.7, sharpness: 0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
            self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 0.3)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.125){
                self.playParametrableVibration(duration: 0.25, intensity: 0.7, sharpness: 0.4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                    self.playParametrableVibration(duration: 0.375, intensity: 0.7, sharpness: 0.7)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.375){
                        self.playParametrableVibration(duration: 0.25, intensity: 0.7, sharpness: 0.4)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                            self.playParametrableVibration(duration: 0.125, intensity: 0.7, sharpness: 0.3)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.125){
                                self.playParametrableVibration(duration: 0.375, intensity: 1.0, sharpness: 1.0)
                            }
                        }
                    }
                }
            }
        }
    }
        
}

