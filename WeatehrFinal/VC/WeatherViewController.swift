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
        setScrollView()
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

    func getForecast() {
        let weatehrApi = WeatherAPIClient()
        let weatherEndPoint = WeatherEndPoint.fiveDayForecast(city: "HsinChu",method: "forecast")
        weatehrApi.forecast(with: weatherEndPoint) { (either) in
            switch either {
            case .value(let forecast):
                //print(forecast)
                // self.cellViewModels = forecast.list.map {
                //     WeatherCellViewModel(imageName:$0.weather[0].icon,day:$0.dt_txt,description:$0.weather[0].description)
                // }
                DispatchQueue.main.async {
                    
                   
                }
            case .error(let error):
                print(error)
            }
        }
    }

    func setScrollView() {
        let scrollView = UIScrollView()
        
         scrollView.frame = CGRect(x: 0, y: view.frame.size.height-200, width: view.frame.size.width, height: 200)

        

        //设置背景色

        scrollView.backgroundColor = UIColor.red
        
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false

        self.view.addSubview(scrollView)
        //设置分页滚动
        
        scrollView.isPagingEnabled = true
        //设置是否可以拉出空白区域
        
        scrollView.bounces = true
        //默认是false。如果是true并且bounces也是true，即使内容尺寸比scrollView的尺寸小，也能垂直推动
        
        scrollView.alwaysBounceVertical = false
        
        
        
        //默认是false。如果是true并且bounces也是true，即使内容尺寸比scrollView的尺寸小，也能水平推动
        
        scrollView.alwaysBounceHorizontal = false
        scrollView.contentInset =  UIEdgeInsetsMake(100, 50, 50, 50)
        
        
        
        //调整指示器（滚动条）的位置
        
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(30, 30, 30, 30)
        
        
        
        //设置指示器（滚动条）的样式
        
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.black//黑色
        
        
        
        //最小的缩放倍数，默认值为1.0
        
        scrollView.minimumZoomScale = 0.2
        
        
        
        //放大的缩放倍数，默认值为1.0
        
        scrollView.maximumZoomScale = 100
        let imagesArray = ["10d","03n","04d"]
        
        
        
        //循环创建ImageView
        
        for i in 0..<imagesArray.count {
            
            
            
            //创建imageView
            
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i)*scrollView.frame.size.width, y:0, width:  scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            //添加图片
            
            imageView.image=UIImage(named: imagesArray[i])
            
            //打开用户交互
            imageView.isUserInteractionEnabled = true
            
            
            //把imageView添加到滚动视图上
            
            scrollView.addSubview(imageView)
            
        }

    }


}
