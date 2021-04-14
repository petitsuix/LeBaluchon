//
//  CurrencyAPI.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class APICurrency {
    
    // renommer correctement les fichiers (et classes)
    // développer logique de currency
    // Affiner le weatherviewcontroller (par une utilisation d'une table view entre autres)
    // utilisation des callbacks
    
    
    var completion: ((_ result: MainCurrencyInfo?, _ error: String?) -> Void)?
    
    let stringUrl = "http://data.fixer.io/api/latest?access_key=4a32bab105ec1a61470fdaabc3fc7ab0&base=EUR&symbols=USD"
    
    func start(completion: ((_ result: MainCurrencyInfo?, _ error: String?) -> Void)?) {
        self.completion = completion
        guard let fixerUrl = URL(string: stringUrl) else { completion?(nil, "Mauvaise URL"); return }
        URLSession.shared.dataTask(with: fixerUrl, completionHandler: response).resume()
        print("\(fixerUrl)")
    }
    
    func response(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        
        if let error = error {
            // completionHandler
            print("error fetching data: \(error.localizedDescription)")
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("error invalid response")
            return
        }
        
        guard response.statusCode == 200 else { // ça peut être d'autre status code valides (d'autres codes)
            print("Invalid status code")
            return
        }
        
        guard let data = data else {
            print("empty data")
            completion?(nil, error?.localizedDescription)
            return
        }
        print("\(data)")
        DispatchQueue.main.async {
            do {
                let decodedData = try JSONDecoder().decode(MainCurrencyInfo.self, from: data)
                self.completion?(decodedData, nil)
                // completionHandler
            } catch let error {
                self.completion?(nil, error.localizedDescription)
                print("decoding error: \(error.localizedDescription)")
                print("\(error)")
            }
        }
    }
}
