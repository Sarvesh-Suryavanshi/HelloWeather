//
//  SideMenuViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

struct Menu: Hashable {
    let title: String
    let showSegmentControl: Bool
}


class SideMenuViewController: UITableViewController {

    
    // MARK: - Properties
    
    static let identifier: String = String(describing: SideMenuViewController.self)

    private var dataSource: UITableViewDiffableDataSource<Int, Menu>!
    
    private let menus = [Menu(title: "Temperature", showSegmentControl: true),
                         Menu(title: "Contact Us", showSegmentControl: false),
                         Menu(title: "Logout", showSegmentControl: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupMenus()
    }

    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, menu in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier, for: indexPath) as? SideMenuCell else { return UITableViewCell() }
            cell.configureCell(menu: menu)
            return cell
        })
    }
    
    func setupMenus() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Menu>()
        snapshot.appendSections([1])
        snapshot.appendItems(self.menus)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
