//
//  HomeViewModel.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation

class HomeViewModel {
    
    private weak var view: HomeViewProtocol?
    private let model: HomeModelProtocol?
    
    private var weatherForecast: WeatherModel?
    
    
    internal lazy var currentPlace: Place = {
        return Place(id: 1125257,
              name: "Mumbai, Maharashtra, India", region: "Maharashtra", country: "India",
              lat: 18.98, lon: 72.83,
              url: "mumbai-maharashtra-india")
    }()
    
    init(model: HomeModelProtocol, view: HomeViewProtocol) {
        self.model = model
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelProtocol {
   
    var hours: [Hour] {
        guard
            self.hasForecastData,
            let forecastDay = self.weatherForecast?.forecast?.forecastday.first,
            !forecastDay.hour.isEmpty else { return [] }
        return forecastDay.hour
    }
    
    var hasForecastData: Bool {
        guard let forecast = weatherForecast?.forecast, !forecast.forecastday.isEmpty else { return false }
        return true
    }
    
    var selectedPlace: Place {
        return self.currentPlace
    }
    
    var locationName: String {
        return weatherForecast?.location.name ?? "Hello Weather"
    }
    
    var cloudPercentage: String {
        return weatherForecast?.current.cloud.percentageFormat ?? ""
    }
    
    var humidityPercentage: String {
        return weatherForecast?.current.humidity.percentageFormat ?? ""
    }
    
    var preasure: String {
        return weatherForecast?.current.pressureMB.pressureFormatting ?? ""
    }
    
    var windSpeed: String {
        return weatherForecast?.current.windKph.speedFormatting ?? ""
    }
    
    var temperature: String {
        return weatherForecast?.current.tempC.temperatureFormat ?? ""
    }
    
    var date: String {
        return weatherForecast?.current.lastUpdated.displayText ?? ""
    }
    
    var weatherStatus: String {
        return weatherForecast?.current.condition.text ?? ""
    }
    
    func fetchWeather(for place: Place) {
        self.currentPlace = place
        self.model?.fetchWeather(for: place, completion: { [weak self] weatherForecast in
            guard let weakSelf = self else { return }
            weakSelf.weatherForecast = weatherForecast
            if let _ = weatherForecast {
                DispatchQueue.main.async {
                    weakSelf.view?.didReceivesWeatherDetails()
                }
            }
        })
    }
    
    func fetchWeatherForecase(for place: Place, days: Int) {
        self.currentPlace = place
        self.model?.fetchWeatherForecase(for: place, days: days, completion: { [weak self] weatherForecast in
            guard let weakSelf = self else { return }
            weakSelf.weatherForecast = weatherForecast
            if let _ = weatherForecast {
                DispatchQueue.main.async {
                    weakSelf.view?.didReceivesWeatherDetails()
                }
            }
        })
    }
    
    func fetchSearchResults(searchText: String) {
        if searchText.count > 2 {
            self.model?.fetchSearchResults(searchText: searchText, completion: { [weak self] places in
                guard let weakSelf = self else { return }
                if let places = places {
                    DispatchQueue.main.async {
                        weakSelf.view?.didReceives(searchResults: places)
                    }
                }
            })
        }
    }
}

extension Double {
    
    var temperatureFormat: String {
        return "\(Int(self).description)°"
    }
    
    var speedFormatting: String {
        return "\(self.description) Km/h"
    }
    

}

extension Int {
    
    var percentageFormat: String {
        return "\(self.description)%"
    }
    
    var pressureFormatting: String {
        return "\(self.description) mBar"
    }
}
