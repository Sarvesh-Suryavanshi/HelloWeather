//
//  AppExtensions.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

// MARK: - DateFormatter Extension

extension DateFormatter {
    
    static var parsingDF : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }
    
    static var displayDF: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }
    
    static var displayTimeDF: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
}

// MARK: - Date Extension

extension Date {
    
    var displayText: String {
        return DateFormatter.displayDF.string(from: self)
    }
    
    var displayTimeText: String {
        return DateFormatter.displayTimeDF.string(from: self)
    }
}

// MARK: - String Extension

extension String {
    
    var url: URL? {
        return URL(string: "https:\(self)")
    }
}

// MARK: - Int Extension

extension Int {
    
    var percentageFormat: String {
        return "\(self.description)%"
    }
    
    var pressureFormatting: String {
        return "\(self.description) mBar"
    }
}

// MARK: - Double Extension

extension Double {
    
    var toInt: Int {
        return Int(self)
    }
}

// MARK: - UIImageView Extension

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

// MARK: - UILabel Extension

extension UILabel {
    
    func addAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.4
        animation.duration = 0.75
        animation.repeatCount = .infinity
        animation.autoreverses = true
        self.layer.add(animation, forKey: nil)
    }
    
    func removeAnimation() {
        self.layer.removeAllAnimations()
    }
}
