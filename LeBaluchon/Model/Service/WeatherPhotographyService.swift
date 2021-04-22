//
//  WeatherPhotographyService.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import UIKit

class APIWeatherPhoto: HandleResponseDelegate {
    
    func getUrl(from collectionId: String) -> String {
        let stringUrl = "https://api.unsplash.com/collections/\(collectionId)/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok"
        return stringUrl
    }
    
    func fetchWeatherPhotoData(collectionId: String, completion: @escaping(Result<[MainWeatherPhotoInfo], ServiceError>) -> Void) {
        guard let unsplashPhotoUrl = URL(string: getUrl(from: collectionId)) else {
            return completion(.failure(.invalidUrl))
        }
        URLSession.shared.dataTask(with: unsplashPhotoUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: [MainWeatherPhotoInfo].self, data, response, error)
            completion(result)
        }).resume()
    }
}
