//
//  CurrentWeatherTableViewController.swift
//  pg5601_8002
//
//  Created by 8002 on 26/02/2021.
//

import UIKit
import CoreLocation

class CurrentWeatherTableViewController: UITableViewController {
    
    var weatherHandler = WeatherHandler()
    
    var weatherForecast = [Timeseries]()
    var forecastUnits: Meta! = nil
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today's forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherHandler.delegate = self
    }
    
    let cellTitles = [
        ["Air pressure", "Air temperature", "Cloud area fraction", "Relative humidity", "Wind direction", "Wind speed"],
        ["Next hour", "Next 6 hours", "Next 12 hours"]
    ]
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Currently" : "Later today"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath)
        
        let title = cellTitles[indexPath.section][indexPath.row]
        cell.textLabel?.text = title
        
        if weatherForecast.count > 0 {
            let forecast = weatherForecast[0]
            let units = forecastUnits.units
            
            let symbolCode1H = forecast.data.next1Hours?.summary.symbol_code ?? "cannot fetch data"
            let symbolCode6H = forecast.data.next1Hours?.summary.symbol_code ?? "cannot fetch data"
            let symbolCode12H = forecast.data.next1Hours?.summary.symbol_code ?? "cannot fetch data"
            
            
            let detailText = [
                [
                    "\(forecast.data.instant.details.airPressureAtSeaLevel) \(units.airPressureAtSeaLevel)",
                    "\(forecast.data.instant.details.airTemperature) \(units.airTemperature)",
                    "\(forecast.data.instant.details.cloudAreaFraction) \(units.cloudAreaFraction)",
                    "\(forecast.data.instant.details.relativeHumidity) \(units.relativeHumidity)",
                    "\(forecast.data.instant.details.windFromDirection) \(units.windFromDirection)",
                    "\(forecast.data.instant.details.windSpeed) \(units.windSpeed)"
                ],
                [
                    "\(symbolCodeToPlainText(symbolCode: symbolCode1H))",
                    "\(symbolCodeToPlainText(symbolCode: symbolCode6H))",
                    "\(symbolCodeToPlainText(symbolCode: symbolCode12H))"
                ]
            ]
            
            let detail = detailText[indexPath.section][indexPath.row]
            
            cell.detailTextLabel?.text = detail
        }
        
        return cell
    }
}

//MARK: - WeatherHandlerDelegate

extension CurrentWeatherTableViewController: WeatherHandlerDelegate {
    func didFetchWeatherForecast(_ timeseries: [Timeseries], _ meta: Meta) {
        self.weatherForecast = timeseries
        self.forecastUnits = meta
        
        // Send data to forecast
        DispatchQueue.main.async {
            if let navVC = self.tabBarController?.viewControllers?[1] as? UINavigationController {
                let forecastTab = navVC.topViewController as! ForecastCollectionViewController
                forecastTab.weatherForecast = self.weatherForecast
                forecastTab.forecastUnits = self.forecastUnits
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        
        let errorAlert = UIAlertController(title: "No connection", message: "Not receiving data. Please try again later.", preferredStyle: .alert)

        errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(errorAlert, animated: true)
        
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension CurrentWeatherTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherHandler.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
//        If you don't grant location access fast enough the first time the app is run, this alert will fire even though fetchWeather is successful.
//        Have therefore commented the alert below. Feel free to uncomment to view it in action.
        
//        let errorAlert = UIAlertController(title: "No connection", message: "Check your connection, make sure your location service is turned on, set your simulator's location to 'custom location', and try again.", preferredStyle: .alert)
//
//        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//        self.present(errorAlert, animated: true)
        
        print(error)
    }
}

