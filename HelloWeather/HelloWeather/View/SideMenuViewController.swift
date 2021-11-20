//
//  SideMenuViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit
import SideMenu

/// Menu Options Enum
enum Menu: String, Hashable {
    
    case temperatureMenu = "Temperature Unit"
    case windSpeedMenu = "Wind Speed"
    case contactUsMenu = "Contact us"
    case logout = "Logout"
    
    var showSegmentControl: Bool {
        switch self {
        case .temperatureMenu, .windSpeedMenu:
            return true
        default:
            return false
        }
    }
    var segmentControlOptions: Int {
        switch self {
        case .temperatureMenu:
            return 2
        case .windSpeedMenu:
            return 2
        default:
            return 0
        }
    }
}

///SideMenu Protocol Definition
protocol SideMenuProtocol: AnyObject {
    func didUpdateAppSettings()
}

/// SideMenuView Controller
class SideMenuViewController: UITableViewController {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: SideMenuViewController.self)
    private var dataSource: UITableViewDiffableDataSource<Int, Menu>!
    weak var delegate: SideMenuProtocol?
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupMenus()
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, menu in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier, for: indexPath) as? SideMenuCell else { return UITableViewCell() }
            cell.configureCell(menu: menu)
            cell.delegate = self
            return cell
        })
    }
    
    func setupMenus() {
        let menus: [Menu] = [.temperatureMenu, .windSpeedMenu, .contactUsMenu, .logout]
        var snapshot = NSDiffableDataSourceSnapshot<Int, Menu>()
        snapshot.appendSections([1])
        snapshot.appendItems(menus)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SideMenuViewController: SideMenuCellProtocol {
    func didUpdateAppSettings() {
        self.delegate?.didUpdateAppSettings()
    }
}
