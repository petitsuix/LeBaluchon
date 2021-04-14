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
                self.image = image
            }
        }.resume()
    }
}
