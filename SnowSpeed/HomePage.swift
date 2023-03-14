//
//  HomePage.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import SwiftUI

struct HomePage: View {
    @Binding var records: [SpeedRecord]
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($records) { $record in
                /*
                NavigationLink(destination: View  destination: RecordDetailView(record: $record)) {
                    CardView(record: record)
                }
                 */
                CardView(record: record)
                .listRowBackground(Color.orange)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            NavigationLink(destination: ContentView()) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Start New Record")
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(records: .constant(SpeedRecord.sampleData), saveAction: {})
    }
}
