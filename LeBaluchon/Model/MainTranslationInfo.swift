//
//  MainTranslationInfo.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import Foundation

struct MainTranslationInfo: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [Translations]
}

struct Translations: Decodable {
    let translatedText: String
}
