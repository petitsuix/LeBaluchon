//
//  WeatherIDs.swift
//  LeBaluchon
//
//  Created by Richardier on 29/04/2021.
//

import Foundation

enum Album: String {
    case lyon
    case newyork
}

extension Album {
    var albumID: String {
        switch self {
        case .lyon :
            return "426804"
        case .newyork :
            return "3541178"
        }
    }
}

enum WeatherCityID: String {
    case lyon
    case newyork
}

extension WeatherCityID {
    var cityID: String {
        switch self {
        case .lyon :
            return "2996944"
        case .newyork :
            return "5128581"
        }
    }
}
