//
//  PersistentStore.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 20/11/21.
//

import RealmSwift

/// This class is responsible for  handling CRUD operations on Realm
class PersistentStore {
    
    // MARK: - Public Properties
    
    static let shared = PersistentStore()
    
    // MARK: - Private Properties
    
    private var realmInstance: Realm {
        try! Realm()
    }
    
    // Private Initializor
    
    private init() {}
}

// MARK: - Extension for CRUD operations for general objects in Realm

extension PersistentStore {
    
    var place: Place {
        let realm = self.realmInstance
        let objects = realm.objects(Place.self)
        if objects.isEmpty {
            let place = Place(id: 1125257, name: "Mumbai, Maharashtra, India", region: "Maharashtra",
                              country: "India", lat: 18.98, lon: 72.83)
            try! realm.write {
                realm.add(place)
            }
        }
        return objects.first!
    }
    
    func update(object: Object) {
        let realm = self.realmInstance
        try! realm.write({
            let objects = realm.objects(type(of: object))
            realm.delete(objects)
            realm.add(object)
        })
    }
}

// MARK: - Extension for CRUD operations for AppSettings

extension PersistentStore {
    
    /// Returns AppSettings object from Realm
    var appSettings: AppSettings {
        let realm = self.realmInstance
        let objects = realm.objects(AppSettings.self)
        if objects.isEmpty {
            let appSettings = AppSettings()
            try! realm.write {
                realm.add(appSettings)
            }
        }
        return objects.first!
    }
    
    /// Updates AppSettings isTemperatureInDegree property
    /// - Parameter isTemperatureInDegree: isTemperatureInDegree description
    func updateAppSettings(isTemperatureInDegree: Bool) {
        let appSettings = PersistentStore.shared.appSettings
        let realm = self.realmInstance
        try! realm.write {
            appSettings.isTemperatureInDegree = isTemperatureInDegree
        }
    }
    
    /// Updates AppSettings isWindSpeedKMPH property
    /// - Parameter isWindSpeedKMPH: isWindSpeedKMPH description
    func updateAppSettings(isWindSpeedKMPH: Bool) {
        let appSettings = PersistentStore.shared.appSettings
        let realm = self.realmInstance
        try! realm.write {
            appSettings.isWindSpeedKMPH = isWindSpeedKMPH
        }
    }
}
