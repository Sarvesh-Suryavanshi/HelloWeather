//
//  Place.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 18/11/21.
//

import Foundation

// MARK: - SearchResult
struct Place: Codable, Hashable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat, lon: Double
    let url: String
}
