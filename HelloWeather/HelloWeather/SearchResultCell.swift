//
//  SearchResultCell.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier: String = String(describing: SearchResultCell.self)
    
    // MARK: - Public Methods
    
    func configureCell(place: Place) {
        self.titleLabel.text = "\(place.name)"
        self.subTitleLabel.text = place.region
    }
}
