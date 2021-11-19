//
//  WeatherCollectionCell.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

class WeatherCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let reuseIdentifier: String = String(describing: WeatherCollectionCell.self)
    
    func configureCell(hour: Hour) {
        self.temperatureLabel.text = hour.tempC.temperatureFormat
        self.timeLabel.text = hour.time.displayTimeText
        
        if let iconURL = hour.condition.icon.url {
            self.iconView.loadImage(imageURL: iconURL)
        }
    }
}


extension UIImageView {
    
    func loadImage(imageURL: URL) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

extension String {
    
    var url: URL? {
        return URL(string: "https:\(self)")
    }
}
