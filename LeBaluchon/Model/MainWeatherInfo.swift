//
//  MainWeatherInfo.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import Foundation

struct MainWeatherInfo: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Weather: Decodable {
    let id: Float
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
}
