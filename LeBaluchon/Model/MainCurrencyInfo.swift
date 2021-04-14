//
//  MainCurrencyInfo.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import Foundation

struct MainCurrencyInfo: Decodable {
    let rates: Rate
    let base: String
    let success: Bool
}

struct Rate: Decodable {
    let USD: Float?
}
