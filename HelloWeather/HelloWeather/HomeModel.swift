//
//  HomeModel.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation

class HomeModel {
    private let mimimumSearchCount = 3
}

// MARK: - HomeModelProtocol Methods

extension HomeModel: HomeModelProtocol {
    
    func fetchWeather(for place: Place, completion: @escaping (Weather?) -> Void) {
        
        NetworkClient.loadAndParse(request: API.currentWeather(place.name).rawValue,
                                   outputType: Weather.self) { result in
            switch result {
            case .success(let weather):
                completion(weather)
            default:
                completion(nil)
            }
        }
    }
    
    func fetchWeatherForecase(for place: Place, days: Int, completion: @escaping (Weather?) -> Void) {
        
        NetworkClient.loadAndParse(request: API.forecase(place.name, days).rawValue,
                                   outputType: Weather.self) { result in
            switch result {
            case .success(let weather):
                completion(weather)
            default:
                completion(nil)
            }
        }
    }
    
    func fetchSearchResults(searchText: String, completion: @escaping ([Place]?) -> Void) {
        
        if searchText.count > self.mimimumSearchCount {
            NetworkClient.loadAndParse(request: API.search(searchText).rawValue,
                                       outputType: [Place].self) { result in
                switch result {
                case .success(let searchResult):
                    completion(searchResult)
                default:
                    completion(nil)
                }
            }
        }
    }
}
