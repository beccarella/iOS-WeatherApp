//
//  ForecastCollectionViewController.swift
//  pg5601_8002
//
//  Created by 8002 on 26/02/2021.
//

import UIKit

class ForecastCollectionViewController: UICollectionViewController {
    
    var weatherForecast: [Timeseries]!
    var days = [Timeseries]()
    var day: Timeseries! = nil
    var forecastUnits: Meta!
    
    var numOfDay: Int = 0
    var timeFound: Bool = false
    
    var weekdays: [String] = [
            "Mandag",
            "Tirsdag",
            "Onsdag",
            "Torsdag",
            "Fredag",
            "Lørdag",
            "Søndag"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 180)
        collectionView.collectionViewLayout = layout
        
        filterDays()
    }
    
    func filterDays() {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH"
        timeFormatter.locale = Locale(identifier: "nb_NO")
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        dayFormatter.locale = Locale(identifier: "nb_NO")
        
        
        for i in 0..<weatherForecast.count {
            if i != 0 {
//                Check if new day
                if dayFormatter.string(from: weatherForecast[i].time) != dayFormatter.string(from: weatherForecast[i-1].time) {
                    numOfDay += 1
                    if numOfDay == 8 {
                        break
                    }
//                    print("NEW DAY \(dayFormatter.string(from: weatherForecast[i].time))")
                    days.append(day)
                    timeFound = false
                }
            }

//            Print current day
//            print(timeFormatter.string(from: weatherForecast[i].time))
            
//            Check if number is 6
            if Int(timeFormatter.string(from: weatherForecast[i].time))! == 6 {
//                print("CORRECT")
                day = weatherForecast[i]
                timeFound = true
            } else {
                if timeFound != true {
                    if Int(timeFormatter.string(from: weatherForecast[i].time))! > 6 {
                        // If number is higher than 6, check if number before or after 6 is closest to 6
                        if i != 0 {
                            if (Int(timeFormatter.string(from: weatherForecast[i].time))! - 6) > (6 - Int(timeFormatter.string(from: weatherForecast[i-1].time))!) {
//                                print("LOWER")
                                day = weatherForecast[i-1]
                                timeFound = true
                            } else {
//                                print("HIGHER")
                                day = weatherForecast[i]
                                timeFound = true
                            }
                        } else {
//                            print("HIGHER")
                            day = weatherForecast[i]
                            timeFound = true
                        }
                    }
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as! ForecastCollectionViewCell
        
        if days[indexPath.row].data.next1Hours?.details?.precipitationAmount != nil {
            cell.rainLvlLabel.text = "\(Int((days[indexPath.row].data.next1Hours?.details!.precipitationAmount)!)) \(forecastUnits.units.precipitationAmount)"
        } else {
            cell.rainLvlLabel.text = "No data"
        }
        
        let imageName = String(days[indexPath.row].data.next1Hours?.summary.symbol_code ?? "_no_data_")
//        print(imageName)
        
        cell.iconImageView.image = UIImage(named: imageName)
        
        let weekday = Calendar.current.component(.weekday, from: days[indexPath.row].time)
        cell.weekdayTxtLabel.text = weekdays[weekday-1]
        
        return cell
    }
}
