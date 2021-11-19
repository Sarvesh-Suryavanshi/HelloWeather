//
//  SearchResultsViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

protocol SearchResultsProtocol: AnyObject {
    func didSelect(place: Place, at indexPath: IndexPath)
}

class SearchResultsViewController: UITableViewController {

    // MARK: - Properties
    
    static var identifier: String { "SearchResultsViewController" }
    private var dataSource: UITableViewDiffableDataSource<Int, Place>!
    weak var delegate: SearchResultsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDataSource()
        
    }

    // MARK: - Table view data source

    private func addDataSource(){
        self.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, place in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else { return UITableViewCell() }
                cell.configureCell(place: place)
            return cell
        })
    }
    
    func updateTableView(places: [Place] = []) {
        var screenshot = NSDiffableDataSourceSnapshot<Int, Place>()
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
