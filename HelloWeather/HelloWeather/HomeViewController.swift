//
//  HomeViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 18/11/21.
//

import UIKit
import SideMenu
import Realm
import RealmSwift

class SearchResultsView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
}


class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            self.temperatureLabel.addAnimation()
        }
    }
    
    @IBOutlet weak var waetherStatusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var showForecastBtn: UIButton!
    
    
    // MARK: - Properties
    
    private var dataSource: UITableViewDiffableDataSource<Int, Place>!
    private var sideMenu: SideMenuNavigationController!
    private var viewModel: HomeViewModelProtocol?
    private lazy var defaultPlace: Place = Place(id: 1125257, name: "Mumbai, Maharashtra, India", region: "Maharashtra",
                                            country: "India", lat: 18.98, lon: 72.83)
    
    private var searchController: UISearchController!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        setupSearchController()
        setupSideMenu()
        self.viewModel?.fetchWeatherForecase(for: PersistentStore.shared.place, days: 1)
    }
    
    private func setupViewModel() {
        self.viewModel = HomeViewModel(model: HomeModel(), view: self)
    }
    
    private func setupSearchController() {
        let searchResultController = Builder.buildSearchResultView()
        searchResultController?.delegate = self
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
    }
    
    private func setupSideMenu() {
        guard let sideMenuView = Builder.buildSideMenuView() else { return }
        sideMenuView.delegate = self
        self.sideMenu = SideMenuNavigationController(rootViewController: sideMenuView)
        self.sideMenu.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
    }
    
    private func updateWeatherDetails() {
        
        guard let viewModel = self.viewModel else { return }
        self.temperatureLabel.text = viewModel.temperature
        self.temperatureLabel.removeAnimation()
        self.waetherStatusLabel.text = viewModel.weatherStatus
        self.dateLabel.text = viewModel.date
        self.pressureLabel.text = viewModel.preasure
        self.windLabel.text = viewModel.windSpeed
        self.cloudLabel.text = viewModel.cloudPercentage
        self.humidityLabel.text = viewModel.humidityPercentage
        self.showForecastBtn.isEnabled = viewModel.hasForecastData
        self.navigationItem.title = viewModel.locationName
    }
    
    @IBAction func didTapOnMenu() {
        self.present(sideMenu, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationView = segue.destination as? HomeDetailViewController else { return }
        destinationView.viewModel = self.viewModel
    }
}

// MARK: - HomeViewProtocol Methods

extension HomeViewController: HomeViewProtocol {
    
    func didReceivesWeatherDetails() {
        self.updateWeatherDetails()
    }
    
    func didReceives(searchResults: [Place]) {
        print(searchResults)
        
        guard
            !searchResults.isEmpty,
            let searchResultViewController = self.searchController.searchResultsController as? SearchResultsViewController
        else { return }
        searchResultViewController.updateTableView(places: searchResults)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.viewModel?.fetchSearchResults(searchText: searchText)
    }
}

extension HomeViewController: SideMenuProtocol {
    func didUpdateAppSettings() {
        print("Menu Updated")
        self.updateWeatherDetails()
    }
}

extension HomeViewController: SearchResultsProtocol {
    
    func didSelect(place: Place, at indexPath: IndexPath) {
        self.searchController.searchBar.text = ""
        PersistentStore.shared.update(object: place)
        self.viewModel?.fetchWeatherForecase(for: place, days: 1)
    }
}


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
