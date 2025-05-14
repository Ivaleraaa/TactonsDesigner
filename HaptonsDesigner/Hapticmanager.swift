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

    /// Simule une vibration répétée à une fréquence "perçue" (ex: 5 Hz = 5 impulsions/seconde)
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

   }

