//
//  EndPoint.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/1.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import Foundation

protocol EndPoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var appKey: String { get }
}

extension EndPoint {
    var urlComponent: URLComponents {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    var request: URLRequest {
        return URLRequest(url:urlComponent.url!)
    }
}

enum WeatherEndPoint: EndPoint {
    case fiveDayForecast(city: String, method: String)

    var baseUrl: String {
        return "http://api.openweathermap.org"
    }

    var path: String {
        switch self {
        case .fiveDayForecast(let city, let method):
            return "/data/2.5/\(method)"
        }
        return "/data/2.5/forecast"
    }
    
    var queryItems: [URLQueryItem]{
        var components = [URLQueryItem]()
        components.append(URLQueryItem(name: "appid", value: "2265fd05cec7074b3e06971a9fde9055"))
        components.append(URLQueryItem(name: "lang", value: "zh_TW"))
        components.append(URLQueryItem(name: "units", value: "metric"))
        switch self {
            case .fiveDayForecast(let city, let method):
                components.append(URLQueryItem(name: "q", value: city))
        }
        

        return components
    }
    
    var appKey: String{
        return "2265fd05cec7074b3e06971a9fde9055"
    }
}
