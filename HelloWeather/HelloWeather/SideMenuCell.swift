//
//  SideMenuCell.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    static let reuseIdentifier: String = String(describing: SideMenuCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func segmentControlValueChanged() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(menu: Menu) {
        
        self.titleLabel.text = menu.title
        self.segmentControl.isHidden = !menu.showSegmentControl
    }
    
}
