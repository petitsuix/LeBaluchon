//
//  MainCurrencyInfo.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import Foundation

struct MainCurrencyInfo: Decodable {
    let rates: [String: Float]
    let base: String
    let success: Bool
}
