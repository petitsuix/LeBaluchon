//
//  WeatherAPI.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

class APIMeteo {
    
    var completion: ((_ result: MainWeatherInfo?, _ error: String?) -> Void)?
    
    let stringUrl = "https://api.openweathermap.org/data/2.5/weather?id=5128581&appid=2f4240e158347092c4e7a70e148d6ed8&units=metric&lang=fr"
    
    
    
    func start(completion: ((_ result: MainWeatherInfo?, _ error: String?) -> Void)?) {
        self.completion = completion
        guard let openWeatherUrl = URL(string: stringUrl) else { completion?(nil, "Mauvaise URL"); return }
        URLSession.shared.dataTask(with: openWeatherUrl, completionHandler: response).resume()
        print("\(openWeatherUrl)")
    }
    
    func response(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        
        if let error = error {
            // completion handler
            print("error fetching data: \(error.localizedDescription)")
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            print ("error invalid response")
            return
        }
        
        guard response.statusCode == 200 else {
            print("Invalid status code")
            return
        }
        
        guard let data = data else {
            print("empty data")
            completion?(nil, error?.localizedDescription)
            return
        }
        DispatchQueue.main.async {
            do {
                let decodedData = try JSONDecoder().decode(MainWeatherInfo.self, from: data)
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
