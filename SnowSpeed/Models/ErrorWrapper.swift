//
//  ErrorWrapper.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
