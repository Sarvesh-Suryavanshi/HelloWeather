//
//  HomeProtocols.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation

// MARK: - HomeView Protocol

protocol HomeViewProtocol: AnyObject {
    
    func didReceives(searchResults: [Place])
    
    func didReceivesWeatherDetails()
}

// MARK: - HomeViewModel Protocol

protocol HomeViewModelProtocol: AnyObject {
    
    var temperature: String { get }
    
    var date: String { get }
    
    var weatherStatus: String { get }
    
    var cloudPercentage: String { get }
    
    var humidityPercentage: String { get }
    
    var preasure: String { get }
    
    var windSpeed: String { get }
    
    var locationName: String { get }
    
    var hasForecastData: Bool { get }
    
    var hours: [Hour] { get }
    
    func fetchSearchResults(searchText: String)
    
    func fetchWeather(for place: Place)
    
    func fetchWeatherForecase(for place: Place, days: Int)
}

// MARK: - HomeModel Protocol

protocol HomeModelProtocol: AnyObject {
    
    func fetchSearchResults(searchText: String, completion: @escaping ([Place]?) -> Void)
    
    func fetchWeather(for place: Place, completion: @escaping (Weather?) -> Void)
    
    func fetchWeatherForecase(for place: Place, days: Int, completion: @escaping (Weather?) -> Void)
}
