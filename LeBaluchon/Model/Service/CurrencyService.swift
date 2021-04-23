//
//  CurrencyAPI.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class FixerApi: HandleResponseDelegate {
   
    
    private var task: URLSessionDataTask?
    private var urlSession: URLSession

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    private let stringUrl = "http://data.fixer.io/api/latest?access_key=4a32bab105ec1a61470fdaabc3fc7ab0&base=EUR&symbols=USD"
    
    func fetchCurrencyData(completion: @escaping(Result<MainCurrencyInfo, ServiceError>) -> Void) {
        guard let fixerUrl = URL(string: stringUrl) else {
            return completion(.failure(.invalidUrl))
        }
        task?.cancel()
        task = urlSession.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainCurrencyInfo.self, data, response, error)
            completion(result)
        })
        task?.resume()
    }
}

