//
//  RecordStore.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import Foundation
import SwiftUI

class RecordStore: ObservableObject {
    @Published var records: [SpeedRecord] = []

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                      in: .userDomainMask,
                                      appropriateFor: nil,
                                      create: false)
            .appendingPathComponent("records.data")
    }
    
    static func load() async throws -> [SpeedRecord] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let records):
                    continuation.resume(returning: records)
                }
            }
        }
    }

    static func load(completion: @escaping (Result<[SpeedRecord], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let speedRecords = try JSONDecoder().decode([SpeedRecord].self, from: file.availableData)
                DispatchQueue.main.async {
                   completion(.success(speedRecords))
               }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    @discardableResult
    static func save(records: [SpeedRecord]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(records: records) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let recordsSaved):
                    continuation.resume(returning: recordsSaved)
                }
            }
        }
    }
    
    static func save(records: [SpeedRecord], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(records)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(records.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
