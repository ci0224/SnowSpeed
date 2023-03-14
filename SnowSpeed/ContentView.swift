//
//  ContentView.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    // @StateObject var speedRecorder = SpeedRecorder()
    var velocity: String {
        return locationManager.velocity
    }
    @State private var vArr: [String] = []
    
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                Button("Start Recording") {
                    //speedRecorder.startRecording()
                }
                Spacer()
                HStack {
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
                    //speedRecorder.stopRecording()
                }
            }
        }
        .onAppear {
        // Schedule a timer to update the value every 1 second
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.vArr.append(self.velocity)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
