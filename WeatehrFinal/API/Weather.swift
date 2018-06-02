//
//  Weather.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/1.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    var cod: String
    var message: Double
    var cnt: Int
    var list: [ListDay]
    var city: City
}

struct ListDay: Codable {
    var dt : Double
    var main: ListMain
    var weather :[ListWeather]
    var clouds:ListClouds
    var wind:ListWind
    // var rain:ListRain
    var sys:ListSys
    var dt_txt:String
}
struct ListMain: Codable {
    var temp :Double
    var temp_min:Double
    var temp_max:Double
    var pressure:Double
    var sea_level:Double
    var grnd_level:Double
    var humidity:Double
    var temp_kf:Double
}

struct ListWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct ListClouds: Codable {
    var all: Double
}

struct ListWind: Codable {
   var speed: Float
   var deg:Float
}

struct ListRain: Codable {
    var listRain3h: Double
    private enum CodingKeys: String, CodingKey {
        case listRain3h = "3h"
    }
}
struct ListSys: Codable {
    let pod: String
}
struct City: Codable {
    var id: Double
    var name: String
    var coord: CityCoord
    var country: String
    var population: Double
}
struct CityCoord: Codable {
    var lat:Double
    var lon:Double
}

struct Current: Codable {
    var coord: CityCoord
    var weather:[ListWeather]
    var base: String
    var main: CurrentMain
    var visibility: Double
    var wind: ListWind
    var clouds: ListClouds
    var dt: Double
     var sys:CurrentSys
    var id: Double
    var name: String
    var cod: Double
}

struct CurrentMain: Codable {
        let temp: Float
        let pressure: Double
        let humidity: Double
        let temp_min: Double
        let temp_max: Double
}

struct CurrentSys: Codable {
        let type: Int
        let id: Int
        let message: Double
        let country: String
        let sunrise: Double
        let sunset: Double
}