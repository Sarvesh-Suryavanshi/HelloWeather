//
//  API.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 18/11/21.
//

import Foundation


// WeatherAPI.COM


//  API KEY = 23ca91a6706985eb33ff77426059c1b1

/// Enum representing web services
enum API {
    
    case search(String)
    case currentWeather(String)
    case forecase(String, Int)
    case astronomy(String, Date)
    case Sports(String)

    
    var rawValue: URLRequest? {
      
        switch(self) {
            
        case .search(let place):
            guard let apiURL = self.searchURL(place: place) else { return nil }
            return URLRequest(url: apiURL)
            
        case .currentWeather(let place):
            guard let apiURL = self.currentWeatherURL(place: place) else { return nil }
            return URLRequest(url: apiURL)
            
        case .forecase(let place, let days):
            guard let apiURL = self.forecaseURL(place: place, days: days) else { return nil }
            return URLRequest(url: apiURL)
            
        case .astronomy(let place, let date):
            guard let apiURL = self.astronomyURL(place: place, date: date) else { return nil }
            return URLRequest(url: apiURL)
            
        case .Sports(let place):
            guard let apiURL = self.sportsURL(place: place) else { return nil }
            return URLRequest(url: apiURL)
        }
    }
}

extension API {
    
    private static let API_KEY = "ce15f5c469ca42bc833190218211811"
    
    /// Configures base url component
    private var baseURLComponent: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.weatherapi.com"
        return components
    }
        
    private func searchURL(place: String) -> URL? {
        var component = self.baseURLComponent
        component.path = "/v1/search.json"
        component.queryItems = self.standardQueryItems(for: place)
        return component.url
    }
    
    private func currentWeatherURL(place: String) -> URL? {
        var component = self.baseURLComponent
        component.path = "/v1/current.json"
        
        let airQualityQuery = URLQueryItem(name: "aqi", value: "true")
        component.queryItems = [airQualityQuery] + self.standardQueryItems(for: place)
        return component.url
    }
    
    private func forecaseURL(place: String, days: Int) -> URL? {
        var component = self.baseURLComponent
        component.path = "/v1/forecast.json"
        let airQualityQuery = URLQueryItem(name: "aqi", value: "true")
        let daysQuery = URLQueryItem(name: "days", value: days.description)
        component.queryItems = [airQualityQuery, daysQuery] + self.standardQueryItems(for: place)
        return component.url
    }
    
    private func astronomyURL(place: String, date: Date) -> URL? {
        var component = self.baseURLComponent
        component.path = "/v1/astronomy.json"
        let dateQuery = URLQueryItem(name: "dt", value: date.description)
        component.queryItems = [dateQuery] + self.standardQueryItems(for: place)
        return component.url
    }
    
    private func sportsURL(place: String) -> URL? {
        var component = self.baseURLComponent
        component.path = "/v1/sports.json"
        component.queryItems = self.standardQueryItems(for: place)
        return component.url
    }
}


extension API {
    
    private func standardQueryItems(for place: String)-> [URLQueryItem] {
        let placeQuery = URLQueryItem(name: "q", value: place)
        let apiIdQuery = URLQueryItem(name: "key", value: API.API_KEY)
        return [placeQuery, apiIdQuery]
    }
}


// Search
//  https://api.weatherapi.com/v1/search.json?key=ce15f5c469ca42bc833190218211811&q=lon


//  https://cdn.weatherapi.com/weather/64x64/night/176.png

//-   ------------


// SEARCH
//   https://openweathermap.org/data/2.5/find?q={CITY}&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric


// "https://openweathermap.org/data/2.5/find?q=Pune&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric"

// "https://openweathermap.org/data/2.5/find?q=Pune&appid=a04ce05e113a55d85d25970b23391d03&units=metric"
