//
//  SpeedRecorder.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import SwiftUI

class SpeedRecorder: ObservableObject {
    @Published var speed: Double = 0.0
    @ObservedObject var locationManager = LocationManager()
    
    private var timer: Timer?
    
    func startRecording() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // Here, you would replace the call to `getCurrentSpeed()` with your own implementation to retrieve the current speed.
            self.speed = self.getCurrentSpeed()
        }
    }
    
    func stopRecording() {
        timer?.invalidate()
        timer = nil
    }
    
    private func getCurrentSpeed() -> Double {
        // Replace this with your own implementation to retrieve the current speed.
        // This is just a placeholder implementation that returns a random speed.
        return Double(locationManager.velocity) ?? 0.0
    }
}
