//
//  AppSettings.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 20/11/21.
//

import Foundation
import Realm
import RealmSwift
import SwiftUI

class AppSettings: Object {
    
    @objc dynamic var isTemperatureInDegree: Bool = true
    @objc dynamic var isWindSpeedKMPH: Bool = true
}

enum TemperatureUnit: Int {
    case degree
    case farenheight
    
    var textRepresentation: String {
        switch(self){
        case .degree:
            return "°C"
        case .farenheight:
            return "°F"
        }
    }
}

enum WindSpeed: Int {
    case kmph
    case mph
    
    var textRepresentation: String {
        switch(self){
        case .kmph:
            return "km/h"
        case .mph:
            return "m/h"
        }
    }
}
