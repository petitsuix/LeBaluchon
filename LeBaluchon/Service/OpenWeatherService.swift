//
//  OpenWeatherService.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

final class OpenWeatherService: ServiceDecoder {
    
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
    
    func fetchWeatherData(cityId: String, completion: @escaping(Result<MainWeatherInfo, ServiceError>) -> Void) { // Parameter completion is a Result. Induces success or failure
        guard let baseUrl = baseUrl, let openWeatherUrl = URL(string: "\(baseUrl)?id=\(cityId)&appid=\(APIKeys.openWeatherKey)&units=metric&lang=fr") else {
            return completion(.failure(.invalidUrl))
        }
        urlSessionDataTask?.cancel() // Ensures no task is already running
        urlSessionDataTask = urlSession.dataTask(with: openWeatherUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data: data, response: response, error: error)
            completion(result)
        })
        urlSessionDataTask?.resume() // Newly-initialized tasks are in a suspended state, need .resume to actually start the task
    }
}

