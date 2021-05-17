//
//  WeatherPhotographyService.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import UIKit

final class WeatherPhotoServiceUnsplash: ServiceDecoder {
    
    // MARK: - Properties
    
    private var urlSessionDataTask: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    
    static let shared = WeatherPhotoServiceUnsplash() // Singleton pattern. Allows to coordinate operations
    
    // MARK: - Init methods
    
    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    // MARK: - Methods
    
    private func getUrl(from collectionId: String) -> String {
        let stringUrl = "https://api.unsplash.com/collections/\(collectionId)/photos/?client_id=\(APIKeys.unsplashKey)"
        return stringUrl
    }
    
    func fetchWeatherPhotoData(collectionId: String, completion: @escaping(Result<[MainWeatherPhotoInfo], ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        guard let unsplashPhotoUrl = URL(string: getUrl(from: collectionId)) else {
            return completion(.failure(.invalidUrl))
        }
        urlSessionDataTask?.cancel()
        urlSessionDataTask = urlSession.dataTask(with: unsplashPhotoUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: [MainWeatherPhotoInfo].self, data: data, response: response, error: error)
            completion(result)
        })
        urlSessionDataTask?.resume()
    }
}
