//
//  AppExtensions.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

extension UIViewController {
    
    /// Returns name of a current instance of view controller
    class var name: String {
        return String(describing: self)
    }
    
    /// Tells us if loading indicator for current instance of view controller is being shown or not
    /// - Returns: true if loading indicator is already being shown
    func isShowingLoadingIndicator() -> Bool {
        if let _ = self.presentedViewController as? UIAlertController {
            return true
        }
        return false
    }
    
    /// Shows Loading Indicator on current instance of View Controller
    /// - Parameter message: message description
    func showLoadingIndicator(message: String? = "Loading...") {
        if !self.isShowingLoadingIndicator() {
            DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let alertIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
            alertIndicator.hidesWhenStopped = true
            alertIndicator.style = .large
            alertIndicator.startAnimating()
            alertController.view.addSubview(alertIndicator)
            self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /// Dismiss Loading Indicator on current instance of View Controller
    func dismissLoadingIndicator() {
        DispatchQueue.main.async {
            if let alertController = self.presentedViewController as? UIAlertController {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

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

extension Date {
    
    var displayText: String {
        return DateFormatter.displayDF.string(from: self)
    }
    
    var displayTimeText: String {
        return DateFormatter.displayTimeDF.string(from: self)
    }
}

extension TimeInterval {
    
    var displayTime: String {
        guard self > 0 && self < Double.infinity else { return "" }
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d hours", hours, minutes)
    }
}
