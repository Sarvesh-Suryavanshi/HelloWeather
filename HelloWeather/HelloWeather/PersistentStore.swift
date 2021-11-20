//
//  PersistentStore.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 20/11/21.
//

import Foundation
import RealmSwift

class PersistentStore {
    
    static let shared = PersistentStore()
    
    private var realmInstance: Realm {
        try! Realm()
    }
    
   
}

// PLACE

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
    

//    var weather: Weather? {
//        let realm = self.realmInstance
//        let objects = realm.objects(Weather.self)
//        if objects.isEmpty {
//            return nil
//        }
//        return objects.first
//    }
    
    func update(object: Object) {
        self.deleteAllObjects(of: type(of: object))
        let realm = self.realmInstance
        try! realm.write({
            realm.add(place)
        })
    }
    
    private func deleteAllObjects(of type: Object.Type) {
        let realm = self.realmInstance
        let objects = realm.objects(type)
        if !objects.isEmpty {
            try! realm.write({
                objects.forEach { object in
                    realm.delete(object)
                }
            })
        }
    }

}

// APP SETTINGS

extension PersistentStore {
    
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
    
    func updateAppSettings(isTemperatureInDegree: Bool) {
        let appSettings = PersistentStore.shared.appSettings
        let realm = self.realmInstance
        try! realm.write {
            appSettings.isTemperatureInDegree = isTemperatureInDegree
        }
    }
    
    func updateAppSettings(isWindSpeedKMPH: Bool) {
        let appSettings = PersistentStore.shared.appSettings
        let realm = self.realmInstance
        try! realm.write {
            appSettings.isWindSpeedKMPH = isWindSpeedKMPH
        }
    }
}
