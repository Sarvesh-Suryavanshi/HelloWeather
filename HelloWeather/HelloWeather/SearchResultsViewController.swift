//
//  SearchResultsViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

/// SearchResults Protocol Definition
protocol SearchResultsProtocol: AnyObject {
    func didSelect(place: Place, at indexPath: IndexPath)
}

/// View used to show search results (User as input to UISearchController)
class SearchResultsViewController: UITableViewController {
    
    // MARK: - Typealias
    
    typealias DataSource = UITableViewDiffableDataSource<Int, Place>
    typealias Screenshot = NSDiffableDataSourceSnapshot<Int, Place>
    
    // MARK: - Properties
    
    static var identifier: String { "SearchResultsViewController" }
    private var dataSource: DataSource!
    weak var delegate: SearchResultsProtocol?
    
    // MARK: - View Lifecycle Methods
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        self.addDataSource()
    }
    
    // MARK: - Table View Data Source
    
    private func addDataSource(){
        self.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, place in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else { return UITableViewCell() }
            cell.configureCell(place: place)
            return cell
        })
    }
    
    func updateTableView(places: [Place] = []) {
        var screenshot = Screenshot()
        screenshot.appendSections([1])
        screenshot.appendItems(places)
        self.dataSource.apply(screenshot, animatingDifferences: true) {
            print("TableView Updated")
        }
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let place = self.dataSource.itemIdentifier(for: indexPath) {
            self.delegate?.didSelect(place: place, at: indexPath)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
