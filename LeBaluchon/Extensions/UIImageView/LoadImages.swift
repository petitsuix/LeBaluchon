//
//  ExtensionUIImageView.swift
//  LeBaluchon
//
//  Created by Richardier on 12/04/2021.
//

import UIKit

extension UIImageView {
    
    // ⬇︎ Loads the corresponding weather icon (cloudy, sunny...)
    
    func loadIcon(_ icon: String) {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        print("\(urlString)")
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    // ⬇︎ Loads the corresponding city photo (for weather interface's background)
    func loadCityPhoto(_ url: String) {
        
        let urlString = url
        print("\(urlString)")
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
