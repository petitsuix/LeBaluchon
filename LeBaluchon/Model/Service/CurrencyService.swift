//
//  CurrencyAPI.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class APICurrency: HandleResponseDelegate {
    
    private let stringUrl = "http://data.fixer.io/api/latest?access_key=4a32bab105ec1a61470fdaabc3fc7ab0&base=EUR&symbols=USD"
    
    func fetchCurrencyData(completion: @escaping(Result<MainCurrencyInfo, ServiceError>) -> Void) {
        guard let fixerUrl = URL(string: stringUrl) else {
            return completion(.failure(.invalidUrl))
        }
        URLSession.shared.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainCurrencyInfo.self, data, response, error)
            completion(result)
        }).resume()
    }
}

