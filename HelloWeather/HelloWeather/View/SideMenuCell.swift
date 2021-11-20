//
//  SideMenuCell.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit
import RealmSwift

protocol SideMenuCellProtocol: AnyObject {
    func didUpdateAppSettings()
}

class SideMenuCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    static let reuseIdentifier: String = String(describing: SideMenuCell.self)
    private var currentMenu: Menu = .logout
    weak var delegate: SideMenuCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        switch currentMenu {
        case .temperatureMenu:
            if let option = TemperatureUnit.init(rawValue: sender.selectedSegmentIndex) {
                PersistentStore.shared.updateAppSettings(isTemperatureInDegree: option == .degree ? true : false)
                self.delegate?.didUpdateAppSettings()
            }
        case .windSpeedMenu:
            if let option = WindSpeed.init(rawValue: sender.selectedSegmentIndex) {
                PersistentStore.shared.updateAppSettings(isWindSpeedKMPH: option == .kmph ? true : false)
                self.delegate?.didUpdateAppSettings()
            }
        default:
            return
        }
    }
    
    func configureCell(menu: Menu) {
        
        self.currentMenu = menu
        self.titleLabel.text = menu.rawValue
        self.segmentControl.isHidden = !menu.showSegmentControl
        var selectedSegmentIndex = 0
        
        if menu.segmentControlOptions > 0 {
            for index in 0...menu.segmentControlOptions {
                if menu == .temperatureMenu {
                    selectedSegmentIndex = PersistentStore.shared.appSettings.isTemperatureInDegree == true ? 0 : 1
                    if let text = TemperatureUnit.init(rawValue: index)?.textRepresentation {
                        self.segmentControl.setTitle(text, forSegmentAt: index)
                    }
                } else if menu == .windSpeedMenu {
                    selectedSegmentIndex = PersistentStore.shared.appSettings.isWindSpeedKMPH == true ? 0 : 1
                    if let text = WindSpeed.init(rawValue: index)?.textRepresentation {
                        self.segmentControl.setTitle(text, forSegmentAt: index)
                    }
                }
            }
        }
        self.segmentControl.selectedSegmentIndex = selectedSegmentIndex
    }
}
