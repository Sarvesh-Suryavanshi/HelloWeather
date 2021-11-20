//
//  HomeViewModel.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation
import RealmSwift

class HomeViewModel {
    
    private weak var view: HomeViewProtocol?
    private let model: HomeModelProtocol?
    
    private var weatherForecast: Weather?
    
    init(model: HomeModelProtocol, view: HomeViewProtocol) {
        self.model = model
        self.view = view        
    }
}

extension HomeViewModel: HomeViewModelProtocol {
   
    private var appSettings: AppSettings {
        return PersistentStore.shared.appSettings
    }
    
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
        guard let value = (appSettings.isWindSpeedKMPH ? weatherForecast?.current.windKph.description : weatherForecast?.current.windMph.description)
        else { return String() }
        let unit = appSettings.isWindSpeedKMPH ? WindSpeed.kmph.textRepresentation : WindSpeed.mph.textRepresentation
        return "\(value) \(unit)"
    }
    
    var temperature: String {
        guard let value = (appSettings.isTemperatureInDegree ? weatherForecast?.current.tempC.toInt.description : weatherForecast?.current.tempF.toInt.description)
        else { return String() }
        let unit = appSettings.isTemperatureInDegree ? TemperatureUnit.degree.textRepresentation : TemperatureUnit.farenheight.textRepresentation
        return value + unit
    }
    
    var date: String {
        return weatherForecast?.current.lastUpdated.displayText ?? ""
    }
    
    var weatherStatus: String {
        return weatherForecast?.current.condition.text ?? ""
    }
    
    func fetchWeather(for place: Place) {
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

extension Int {
    
    var percentageFormat: String {
        return "\(self.description)%"
    }
    
    var pressureFormatting: String {
        return "\(self.description) mBar"
    }
}

extension Double {
    
    var toInt: Int {
        return Int(self)
    }
}
