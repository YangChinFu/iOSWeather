//
//  WeatherTableViewController.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/1.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import UIKit
class WeatherTableViewController: UITableViewController {

    var cellViewModels =  [WeatherCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrent()
        //getForecast()
        // let weatehrApi = WeatherAPIClient()
        // let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "HsinChu",method: "forecast")
        // weatehrApi.weather(with: weatherEndPoint) { (either) in
        //     switch either {
        //     case .value(let forecast):
        //         //print(forecast)
        //         self.cellViewModels = forecast.list.map {
        //             WeatherCellViewModel(imageName:$0.weather[0].icon,day:$0.dt_txt,description:$0.weather[0].description)
        //         }
        //         DispatchQueue.main.async {
                    
        //             print(self.cellViewModels)
        //             self.tableView.reloadData()
        //         }
        //     case .error(let error):
        //         print(error)
        //     }
        // }
        
    }
    
    func getForecast() {
        let weatehrApi = WeatherAPIClient()
        let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "HsinChu",method: "forecast")
        weatehrApi.forecast(with: weatherEndPoint) { (either) in
            switch either {
            case .value(let forecast):
                //print(forecast)
                self.cellViewModels = forecast.list.map {
                    WeatherCellViewModel(imageName:$0.weather[0].icon,day:$0.dt_txt,description:$0.weather[0].description)
                }
                DispatchQueue.main.async {
                    
                    print(self.cellViewModels)
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }

    func getCurrent() {
        let weatehrApi = WeatherAPIClient()
        let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "HsinChu",method: "weather")
        weatehrApi.current(with: weatherEndPoint) { (either) in
            switch either {
            case .value(let current):
                //print(forecast)
                let timeInterval = Double(current.dt)
                
                // create NSDate from Double (NSTimeInterval)
                let myNSDate = Date(timeIntervalSince1970: timeInterval)
                let formatter = DateFormatter()
                // initially set the format based on your datepicker date / server String
                formatter.dateFormat = "yyyy-MM-dd"
                let dateStr = formatter.string(from: myNSDate) // string purpose I add here
                self.cellViewModels =
                    [WeatherCellViewModel(imageName:current.weather[0].icon,day:dateStr ,description:current.weather[0].description)]
                
                DispatchQueue.main.async {
                    
                    print(self.cellViewModels)
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        // Configure the cell...
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.day
        cell.imageView?.image = UIImage(named: cellViewModel.imageName)
        return cell
    }
}
