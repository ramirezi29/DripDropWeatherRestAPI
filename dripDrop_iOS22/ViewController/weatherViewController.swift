//
//  weatherViewController.swift
//  dripDrop_iOS22
//
//  Created by Ivan Ramirez on 10/18/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit
import CoreLocation

class weatherViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - IBOUTlets
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    var currentLocation: CLLocation? {
        didSet{
            loadViewIfNeeded()
            fetchWeather()
        }
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - This is your job
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        updateUI()
        //
        
        //
        // MARK: - Ask for permission to track location
        WeatherController.shared.locationManger.requestWhenInUseAuthorization()
        
        // MARK: - Work to be done by delegate
        if CLLocationManager.locationServicesEnabled() {
            
            // MARK: set as the delegate and self
            WeatherController.shared.locationManger.delegate = self
            
            // MARK: - Once this is allowed, it will go into your phone and know where you're at
            // THere are other options for accuracy
            WeatherController.shared.locationManger.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            
            WeatherController.shared.locationManger.startUpdatingLocation()
        }
    }//🍕
    
    func updateCurrentWeather() {
        cityLabel.text = "Salt Lake City"
        summaryLabel.text = WeatherController.shared.currentWeather?.summary
        
        //NOTE: - Notice the syntax and the degree symbol. Taken from Emoji tray
        tempLabel.text = "\(Int(WeatherController.shared.currentWeather?.temperature ?? 0))°"
    }
    
    // MARK: -
    func fetchWeather() {
        guard let latitude = currentLocation?.coordinate.latitude,
            let longitude = currentLocation?.coordinate.longitude else {return}
        
        // MARK: - Now fetch
        WeatherController.shared.fetchWeeklyWeather(latitude: latitude, longitude: longitude) { (_) in
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
                self.updateCurrentWeather()
            }
        }
    }//🧀
    
    
    // MARK: - CollectionView DataSource  (Delegate required functions)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherController.shared.arrayOfDailyWeathers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionViewCell
        
        let dailyWeather = WeatherController.shared.arrayOfDailyWeathers?[indexPath.row]
        
        cell?.dailyWeather = dailyWeather
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    // MARK: - Location updated evertime this func is called, double check on this meaning
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }
}//🔥
