//
//  HomeViewModel.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private weak var view: HomeViewProtocol?
    private let model: HomeModelProtocol?
    private var weather: Weather?
    
    // MARK: - Initializer
    
    init(model: HomeModelProtocol, view: HomeViewProtocol) {
        self.model = model
        self.view = view
    }
    
    // MARK: - Private Methods
    
    private var appSettings: AppSettings {
        return PersistentStore.shared.appSettings
    }
}

// MARK: - HomeViewModelProtocol Methods

extension HomeViewModel: HomeViewModelProtocol {
    
    var hours: [Hour] {
        guard
            self.hasForecastData,
            let forecastDay = self.weather?.forecast?.forecastday.first,
            !forecastDay.hour.isEmpty else { return [] }
        return forecastDay.hour
    }
    
    var hasForecastData: Bool {
        guard let forecast = weather?.forecast, !forecast.forecastday.isEmpty else { return false }
        return true
    }
    
    var locationName: String {
        return weather?.location.name ?? "Hello Weather"
    }
    
    var cloudPercentage: String {
        return weather?.current.cloud.percentageFormat ?? ""
    }
    
    var humidityPercentage: String {
        return weather?.current.humidity.percentageFormat ?? ""
    }
    
    var preasure: String {
        return weather?.current.pressureMB.pressureFormatting ?? ""
    }
    
    var windSpeed: String {
        guard let value = (appSettings.isWindSpeedKMPH ? weather?.current.windKph.description : weather?.current.windMph.description)
        else { return String() }
        let unit = appSettings.isWindSpeedKMPH ? WindSpeed.kmph.unitInText : WindSpeed.mph.unitInText
        return "\(value) \(unit)"
    }
    
    var temperature: String {
        guard let value = (appSettings.isTemperatureInDegree ? weather?.current.tempC.toInt.description : weather?.current.tempF.toInt.description)
        else { return String() }
        let unit = appSettings.isTemperatureInDegree ? TemperatureUnit.degree.unitInText : TemperatureUnit.farenheight.unitInText
        return value + unit
    }
    
    var date: String {
        return weather?.current.lastUpdated.displayText ?? ""
    }
    
    var weatherStatus: String {
        return weather?.current.condition.text ?? ""
    }
    
    func fetchWeather(for place: Place) {
        self.model?.fetchWeather(for: place, completion: { [weak self] weather in
            guard let weakSelf = self else { return }
            weakSelf.weather = weather
            if let _ = weather {
                DispatchQueue.main.async {
                    weakSelf.view?.didReceivesWeatherDetails()
                }
            }
        })
    }
    
    func fetchWeatherForecase(for place: Place, days: Int) {
        self.model?.fetchWeatherForecase(for: place, days: days, completion: { [weak self] weather in
            guard let weakSelf = self else { return }
            weakSelf.weather = weather
            if let _ = weather {
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
