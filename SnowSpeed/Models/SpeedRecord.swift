//
//  SpeedRecord.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import Foundation

struct SpeedRecord: Identifiable, Codable {
    let id: UUID
    var title: String
    var lengthInSeconds: Int
    var speedVector: [Double]
    var topSpeed: Double
    var totalDisplacement: Double
    var createTime: Double
    var cityName: String
    
    init(id: UUID = UUID(), title: String, lengthInSeconds: Int, speedVector: [Double], topSpeed: Double, totalDisplacement: Double, createTime: Double = Date().timeIntervalSince1970, cityName: String) {
        self.id = id
        self.title = title
        self.lengthInSeconds = lengthInSeconds
        self.speedVector = speedVector
        self.topSpeed = topSpeed
        self.totalDisplacement = totalDisplacement
        self.createTime = createTime
        self.cityName = cityName
    }
    mutating func setTitle(title: String){
        self.title = title
    }
}

extension SpeedRecord {
    static let sampleData: [SpeedRecord] =
    [
        SpeedRecord(title: "Happy Sample 1", lengthInSeconds: 7, speedVector: [0.00,1.22,4.66, 9.00, 12.01, 2.01, 0.51], topSpeed: 12.01, totalDisplacement: 32.03, cityName: "Davis"),
        SpeedRecord(title: "Happy Sample 2222222", lengthInSeconds: 7, speedVector: [10.00,11.22,14.66, 19.00, 22.01, 12.01, 10.51], topSpeed: 22.01, totalDisplacement: 102.03, cityName: "Huizhou"),
    ]
}
