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
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (d, _, _) in
            DispatchQueue.main.async {
                guard d != nil else { return }
                let image = UIImage(data: d!)
                self.image = image // Image views that call this extension method will get their ".image" property filled with the image retrieved from the given data
            }
        }.resume()
    }
    
    // ⬇︎ Loads the corresponding city photo (for weather interface's background)
    func loadCityPhoto(_ url: String) {
        let urlString = url
        print("\(urlString)")
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (d, _, _) in
            DispatchQueue.main.async {
                guard d != nil else { return }
                let image = UIImage(data: d!)
                self.image = image // Image views that call this extension method will get their ".image" property filled with the image retrieved from the given data
            }
        }.resume()
    }
    
    // ⬇︎ Adds a black shadow to any UIImageView content
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
