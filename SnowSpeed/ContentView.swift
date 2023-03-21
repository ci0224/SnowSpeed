//
//  ContentView.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var records: [SpeedRecord]
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject var locationManager = LocationManager()
    // @StateObject var speedRecorder = SpeedRecorder()
    var velocity: String {
        return locationManager.velocity
    }
    var cityName: String {
        return locationManager.cityName
    }
    @State private var vArr: [String] = []
    @State private var newSpeedRecord : SpeedRecord? = nil
    
    @State private var timer: Timer?
    
    func startRecording() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.vArr.append(self.velocity)
        }
    }
    
    func stopRecording() {
        timer?.invalidate()
        timer = nil
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Button("Start Recording") {
                    startRecording()
                }
                Spacer()
                HStack {
                    Text(cityName)
                        .font(.system(size: 24))
                    Text(vArr.joined(separator: ", "))
                        .font(.system(size: 34))
                }
                .foregroundColor(.white)
                Spacer()
                HStack {
                    Text(velocity)
                        .font(.system(size: 74))
                    Text("km/h")
                        .font(.system(size: 44))
                }
                .foregroundColor(.white)
                Spacer()
                Button("Stop Recording") {
                    stopRecording()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(records: .constant(SpeedRecord.sampleData))
            .previewDevice("iPhone 11")
    }
}
