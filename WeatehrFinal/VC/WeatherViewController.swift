//
//  WeatherViewController.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/2.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    var cellViewModels =  [WeatherCellViewModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrent()
        getForecast()
        // Do any additional setup after loading the view.
    }

    func getCurrent() {
        let weatherApi = WeatherAPIClient()
        let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "Taipei",method: "weather")
        weatherApi.current(with: weatherEndPoint) { (either) in
            switch either {
            case .value(let current):
                let timeInterval = current.dt
                
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

    func getForecast() {
        let weatehrApi = WeatherAPIClient()
        let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "HsinChu",method: "forecast")
        weatehrApi.forecast(with: weatherEndPoint) { (either) in
            switch either {
            case .value(let forecast):
                //print(forecast)
                self.cellViewModels = forecast.list.map {
                    WeatherCellViewModel(imageName:$0.weather[0].icon,day:$0.dt_txt,description:$0.weather[0].description,dt:$0.dt)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                   
                }
            case .error(let error):
                print(error)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherCollectionViewCell
        
        let cellViewModel = cellViewModels[indexPath.row]
        let timeInterval = cellViewModel.dt
        
        cell.imageView.image = UIImage(named: cellViewModel.imageName)
            
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
            
        if let date = dateFormatterGet.date(from: cellViewModel.day){
            cell.timeLabel.text = dateFormatterPrint.string(from: date)
        }
        else {
            print("There was an error decoding the string")
        }
        
        
        // Configure the cell
       
        return cell
    }


}
