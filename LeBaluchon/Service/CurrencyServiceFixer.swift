//
//  CurrencyServiceFixer.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

final class CurrencyServiceFixer: ServiceDecoder {
    
    // MARK: - Properties
    
    private var urlSessionDataTask: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    private var baseUrl: String?

    // MARK: - Init methods
    
    init(urlSession: URLSession, baseUrl: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }
    
    // MARK: - Methods
    
    func fetchCurrencyData(completion: @escaping(Result<MainCurrencyInfo, ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        
        guard let baseUrl = baseUrl, let fixerUrl = URL(string: "\(baseUrl)?access_key=\(APIKeys.fixerKey)&base=EUR&symbols=USD") else { // Ensures that URL is not nil, otherwise return one of the ServiceError
            return completion(.failure(.invalidUrl))
        }
        urlSessionDataTask?.cancel()
        urlSessionDataTask = urlSession.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainCurrencyInfo.self, data: data, response: response, error: error)
            completion(result)
        })
        urlSessionDataTask?.resume()
    }
}


