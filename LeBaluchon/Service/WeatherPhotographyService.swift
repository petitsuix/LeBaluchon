//
//  WeatherPhotographyService.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import UIKit

class WeatherPhotoServiceUnsplash: ServiceDecoder {
    
    static let shared = WeatherPhotoServiceUnsplash()
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)

    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func getUrl(from collectionId: String) -> String {
        let stringUrl = "https://api.unsplash.com/collections/\(collectionId)/photos/?client_id=\(APIKeys.unsplashKey)"
        return stringUrl
    }
    
    func fetchWeatherPhotoData(collectionId: String, completion: @escaping(Result<[MainWeatherPhotoInfo], ServiceError>) -> Void) {
        guard let unsplashPhotoUrl = URL(string: getUrl(from: collectionId)) else {
            return completion(.failure(.invalidUrl))
        }
        task?.cancel()
        task = urlSession.dataTask(with: unsplashPhotoUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: [MainWeatherPhotoInfo].self, passedData: data, passedResponse: response, passedError: error)
            completion(result)
        })
        task?.resume()
    }
}
