//
//  WeatherAPIClient.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/1.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import Foundation

class WeatherAPIClient: APIClient {
    var session: URLSession
    
    init(session: URLSession = URLSession.shared){
        self.session = session
    }
    
    func forecast(with endpoint: WeatherEndPoint, completion: @escaping (Either<Forecast, APIError>) -> Void) {
        let request = endpoint.request
        
        self.fetch(with: request) { (either:Either<Forecast, APIError>) in
            switch either {
            case .value(let forecast):
                let forecast = forecast
                completion(.value(forecast))
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func current(with endpoint: WeatherEndPoint, completion: @escaping (Either<Current, APIError>) -> Void) {
        let request = endpoint.request
        
        self.fetch(with: request) { (either:Either<Current, APIError>) in
            switch either {
            case .value(let current):
                completion(.value(current))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
