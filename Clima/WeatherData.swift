//
//  WeatherData.swift
//  Clima
//
//  Created by Diego Bustos on 2021-01-19.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatheData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
