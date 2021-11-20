//
//  HomeDetailViewController.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit
import MapKit
import RealmSwift

class HomeDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mapkitView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var temperatureLabel: UILabel!

    weak var viewModel: HomeViewModelProtocol?
    private var dataSource: UICollectionViewDiffableDataSource<Int, Hour>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocation(place: PersistentStore.shared.place)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = flowLayout
        addDataSource()
        updateCollectionView()
    }
    
    func setLocation(place: Place) {
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = place.lat
        region.center.longitude = place.lon
        region.span.longitudeDelta = 0.2
        region.span.latitudeDelta = 0.2
        self.mapkitView.setRegion(region, animated: false)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Collection view data source
    
    
    private func addDataSource(){
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, place in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.reuseIdentifier, for: indexPath) as? WeatherCollectionCell
            else { return UICollectionViewCell() }
            cell.configureCell(hour: place)
            return cell
        })
    }
    
    func updateCollectionView() {
        
        if let viewModel = self.viewModel {
            var screenshot = NSDiffableDataSourceSnapshot<Int, Hour>()
            screenshot.appendSections([1])
            screenshot.appendItems(viewModel.hours)
            self.dataSource.apply(screenshot, animatingDifferences: true) { print("TableView Updated") }
            self.temperatureLabel.text = viewModel.temperature
        }
    }
    
    
    private func fetchForecastData() {
        
    }
}


extension HomeDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 150)
    }
}
