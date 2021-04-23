//
//  WeatherAPI.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

class OpenWeatherApi: HandleResponseDelegate {
    
    private var task: URLSessionDataTask?
    private var urlSession: URLSession

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    let newyorkId = "5128581"
    let lyonId = "2996944"
    
    private func getCityId(_ cityId: String) -> String {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=2f4240e158347092c4e7a70e148d6ed8&units=metric&lang=fr"
        return stringUrl
    }
    
    func fetchWeatherData(cityId: String, completion: @escaping(Result<MainWeatherInfo, ServiceError>) -> Void) {
        guard let openWeatherUrl = URL(string: getCityId(cityId)) else {
            return completion(.failure(.invalidUrl))
        }
        task?.cancel()
        task = urlSession.dataTask(with: openWeatherUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data, response, error)
            completion(result)
        })
        task?.resume()
    }
}

