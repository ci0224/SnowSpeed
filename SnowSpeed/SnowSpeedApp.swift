//
//  SnowSpeedApp.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import SwiftUI

@main
struct SnowSpeedApp: App {
    @StateObject private var store = RecordStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomePage(records: $store.records) {
                    Task {
                        do {
                            try await RecordStore.save(records: store.records)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.records = try await RecordStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.records = SpeedRecord.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
