//
//  CurrencyServiceFixer.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class CurrencyServiceFixer: ServiceDecoder {
    static let shared = CurrencyServiceFixer()
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)

    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    private let stringUrl = "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)&base=EUR&symbols=USD"
    
    func fetchCurrencyData(completion: @escaping(Result<MainCurrencyInfo, ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        guard let fixerUrl = URL(string: stringUrl) else { // Ensures that URL is not nil, otherwise return one of the ServiceError
            return completion(.failure(.invalidUrl))
        }
        task?.cancel()
        task = urlSession.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainCurrencyInfo.self, passedData: data, passedResponse: response, passedError: error)
            completion(result)
        })
        task?.resume()
    }
}


