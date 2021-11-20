//
//  WeatherCollectionCell.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

/// Weather cell view for displaying hourly weather data
class WeatherCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier: String = String(describing: WeatherCollectionCell.self)
    
    // MARK: - Public Methods
    
    /// Configures Collection Cell
    /// - Parameter hour: hour description
    func configureCell(hour: Hour) {
        let appSettings = PersistentStore.shared.appSettings
        let unit = appSettings.isTemperatureInDegree ? TemperatureUnit.degree.unitInText : TemperatureUnit.farenheight.unitInText
        let value = (appSettings.isTemperatureInDegree ? hour.tempC.description : hour.tempF.description)
        self.temperatureLabel.text = value + unit
        self.timeLabel.text = hour.time.displayTimeText
        if let iconURL = hour.condition.icon.url {
            self.iconView.loadImage(imageURL: iconURL)
        }
    }
}
