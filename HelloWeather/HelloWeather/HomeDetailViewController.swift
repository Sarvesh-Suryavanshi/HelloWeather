//
//  HomeDetailViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import MapKit
import RealmSwift

/// View that shows hourly weather update for selected place
class HomeDetailViewController: UIViewController {
    
    // MARK: - Typealias
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Hour>
    typealias Screenshot = NSDiffableDataSourceSnapshot<Int, Hour>
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mapkitView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Properties
    
    weak var viewModel: HomeViewModelProtocol?
    private var dataSource: DataSource!
    
    // MARK: - View Lifecycle Methods
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.addDataSource()
        self.updateCollectionView()
        self.updateMap(place: PersistentStore.shared.place)
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 60, height: 150)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    /// Update Map for provided place
    /// - Parameter place: place description
    private func updateMap(place: Place) {
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = place.lat
        region.center.longitude = place.lon
        region.span.longitudeDelta = 0.2
        region.span.latitudeDelta = 0.2
        self.mapkitView.setRegion(region, animated: false)
    }
    
    // MARK: - Collection View Data Source
    
    /// Setting up data source for collection view
    private func addDataSource(){
        self.dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, place in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.reuseIdentifier, for: indexPath) as? WeatherCollectionCell
            else { return UICollectionViewCell() }
            cell.configureCell(hour: place)
            return cell
        })
    }
    
    /// Setting up update logic for collection view
    func updateCollectionView() {
        if let viewModel = self.viewModel {
            var screenshot = Screenshot()
            screenshot.appendSections([1])
            screenshot.appendItems(viewModel.hours)
            self.dataSource.apply(screenshot, animatingDifferences: true) {}
            self.temperatureLabel.text = viewModel.temperature
        }
    }
}
