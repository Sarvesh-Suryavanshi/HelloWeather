//
//  Place.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 18/11/21.
//

import RealmSwift

// MARK: - SearchResult
class Place: Object, Codable {
    
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var region: String
    @objc dynamic var country: String
    @objc dynamic var lat, lon: Double
    
    convenience init(id: Int, name: String, region: String, country: String, lat: Double, lon: Double) {
        self.init()
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
    }
}
