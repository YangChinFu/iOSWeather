//
//  WeatherViewController.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/2.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrent()
        // Do any additional setup after loading the view.
    }

    func getCurrent() {
        let weatherApi = WeatherAPIClient()
        let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "Taipei",method: "weather")
        weatherApi.current(with: weatherEndPoint) { (either) in
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
                DispatchQueue.main.async {
                    
                    self.cityName?.text = current.name
                    self.weatherImg?.image = UIImage(named: current.weather[0].icon)
                    self.cityDescription?.text = current.weather[0].description
                    var myIntValue = Int(current.main.temp)
                    self.cityTemp?.text = String(myIntValue)
                }
                
                
            case .error(let error):
                print(error)
            }
        }
    }



}
