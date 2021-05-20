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
    private let baseUrl: String?
    
    // MARK: - Init methods
        
    init(urlSession: URLSession, baseUrl: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }
    
    // MARK: - Methods
    
//    private func getUrl(from collectionId: String) -> String {
//        let stringUrl = "https://api.unsplash.com/collections/\(collectionId)/photos/?client_id=\(APIKeys.unsplashKey)"
//        return stringUrl
//    }
    
    func fetchWeatherPhotoData(collectionId: String, completion: @escaping(Result<[MainWeatherPhotoInfo], ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        guard let baseUrl = baseUrl, let unsplashPhotoUrl = URL(string: "\(baseUrl)\(collectionId)/photos/?client_id=\(APIKeys.unsplashKey)") else {
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
