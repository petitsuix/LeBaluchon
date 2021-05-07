//
//  OpenWeatherService.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

class OpenWeatherService: ServiceDecoder {
    
    // MARK: - Properties
    
    private var urlSessionDataTask: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    static let shared = OpenWeatherService() // Singleton pattern. Allows to coordinate operations
    
    // MARK: - Init methods
    
    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    // MARK: - Methods
    
    private func getCityId(_ cityId: String) -> String {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(APIKeys.openWeatherKey)&units=metric&lang=fr"
        return stringUrl
    }
    
    func fetchWeatherData(cityId: String, completion: @escaping(Result<MainWeatherInfo, ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        guard let openWeatherUrl = URL(string: getCityId(cityId)) else { // Ensures that URL is not nil, otherwise return the invalidUrl element from ServiceError
            return completion(.failure(.invalidUrl))
        }
        urlSessionDataTask?.cancel()
        urlSessionDataTask = urlSession.dataTask(with: openWeatherUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data: data, response: response, error: error)
            completion(result)
        })
        urlSessionDataTask?.resume() // Newly-initialized tasks are in a suspended state, need .resume to actually start the task
    }
}

