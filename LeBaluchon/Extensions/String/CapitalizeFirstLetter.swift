//
//  ExtensionStringForDecimalPad.swift
//  LeBaluchon
//
//  Created by Richardier on 20/04/2021.
//

import Foundation

extension String {
    
    // ⬇︎ Capitalizes the first letter of a text
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst() // ex: "Bonjour" translates as "Hello", so 'prefix(1).capitalized' would be "H", dropFirst would be "ello".
    }
}
