//
//  ExtensionUIImageView.swift
//  LeBaluchon
//
//  Created by Richardier on 12/04/2021.
//

import UIKit

extension UIImageView {
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
    
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.label.cgColor
    }
}
