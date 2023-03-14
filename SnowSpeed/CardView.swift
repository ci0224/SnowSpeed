//
//  CardView.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import SwiftUI
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

struct CardView: View {
    let record: SpeedRecord
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(record.title)
                .accessibilityAddTraits(.isHeader)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(record.topSpeed)", systemImage: "person.3")
                    .accessibilityLabel("top speed \(record.topSpeed) ")
                Spacer()
                Label("\(record.lengthInSeconds)", systemImage: "clock")
                    .accessibilityLabel("\(record.lengthInSeconds) seconds record")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var record = SpeedRecord.sampleData[0]
    static var previews: some View {
        CardView(record: record)
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
