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
    private var stringUrl: String?  // = "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)&base=EUR&symbols=USD"
//    private var urlString: String = "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)&base=EUR&symbols=USD"
    
    static let shared = CurrencyServiceFixer() // Singleton pattern. Allows to coordinate operations
    
    // MARK: - Init methods
    
    private override init() {}
    
    init(urlSession: URLSession, stringUrl: String = "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)&base=EUR&symbols=USD") {
        self.urlSession = urlSession
        self.stringUrl = stringUrl
    }
    
    // MARK: - Methods
    
    func fetchCurrencyData(completion: @escaping(Result<MainCurrencyInfo, ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        
        guard let stringUrl = stringUrl, let fixerUrl = URL(string: stringUrl) else { // Ensures that URL is not nil, otherwise return one of the ServiceError
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


