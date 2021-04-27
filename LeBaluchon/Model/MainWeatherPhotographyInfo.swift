//
//  MainWeatherPhotographyInfo.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import Foundation

struct MainWeatherPhotoInfo: Decodable {
    let urls: Url
}

struct Url: Decodable {
    let regular: String
}
