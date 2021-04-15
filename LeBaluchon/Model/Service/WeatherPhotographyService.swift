//
//  WeatherPhotographyService.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import UIKit

class APIWeatherPhoto {
    
    var completion: ((_ result: MainWeatherPhotoInfo?, _ error: String?) -> Void)?
    
    
    
    func getUrl(from collectionId: String) -> String {
        let stringUrl = "https://api.unsplash.com/collections/\(collectionId)/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok"
        return stringUrl
    }
    
    func start(collectionId: String, completion: ((_ result: MainWeatherPhotoInfo?, _ error: String?) -> Void)?) {
        self.completion = completion
        guard let unsplashPhotoUrl = URL(string: getUrl(from: collectionId)) else { completion?(nil, "Mauvaise URL"); return }
        URLSession.shared.dataTask(with: unsplashPhotoUrl, completionHandler: response).resume()
        print("\(unsplashPhotoUrl)")
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
                let decodedData = try JSONDecoder().decode([MainWeatherPhotoInfo].self, from: data)
                self.completion?(decodedData.randomElement(), nil)
                // completionHandler
            } catch let error {
                self.completion?(nil, error.localizedDescription)
                print("decoding error: \(error.localizedDescription)")
                print("\(error)")
            }
        }
    }
}
