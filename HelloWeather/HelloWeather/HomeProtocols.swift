//
//  HomeProtocols.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation


protocol HomeViewProtocol: AnyObject {
    
    func didReceives(searchResults: [Place])
    
    func didReceivesWeatherDetails()

}

protocol HomeViewModelProtocol: AnyObject {
    
    var temperature: String { get }
    var date: String { get }
    var weatherStatus: String { get }
    
    var cloudPercentage: String { get }
    var humidityPercentage: String { get }
    var preasure: String { get }
    var windSpeed: String { get }
    
    var selectedPlace: Place { get }
    
    
    var locationName: String { get }

    var hasForecastData: Bool { get }
    
    var hours: [Hour] { get }
    
    func fetchSearchResults(searchText: String)
    
    func fetchWeather(for place: Place)
    
    func fetchWeatherForecase(for place: Place, days: Int)

    
}

protocol HomeModelProtocol: AnyObject {
    
    func fetchSearchResults(searchText: String, completion: @escaping ([Place]?) -> Void)
    
    func fetchWeather(for place: Place, completion: @escaping (WeatherModel?) -> Void)
    
    func fetchWeatherForecase(for place: Place, days: Int, completion: @escaping (WeatherModel?) -> Void)
}
