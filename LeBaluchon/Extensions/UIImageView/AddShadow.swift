//
//  AddShadow.swift
//  LeBaluchon
//
//  Created by Richardier on 29/04/2021.
//

import UIKit

extension UIImageView {
    
    // ⬇︎ Adds a black shadow to any UIImageView content
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
