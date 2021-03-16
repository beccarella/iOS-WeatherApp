//
//  WeatherHandler.swift
//  pg5601_8002
//
//  Created by 8002 on 26/02/2021.
//

// Somewhat inspired by: https://www.udemy.com/course/ios-13-app-development-bootcamp lecture 13: Networking, JSON Parsing, APIs and CoreLocation

import Foundation
import CoreLocation

protocol WeatherHandlerDelegate {
    func didFetchWeatherForecast(_ timeseries: [Timeseries], _ meta: Meta)
    func didFailWithError(error: Error)
}

struct WeatherHandler {
    let weatherURL = "https://api.met.no/weatherapi/locationforecast/2.0/compact"
    
    var delegate: WeatherHandlerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let weatherData = try decoder.decode(WeatherData.self, from: data!)
                    self.delegate?.didFetchWeatherForecast(weatherData.properties.timeseries, weatherData.properties.meta)
                } catch let error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
            }
            task.resume()
        }
    }
}
