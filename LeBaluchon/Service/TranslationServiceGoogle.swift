//
//  TranslationServiceGoogle.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import UIKit

final class TranslationServiceGoogle: ServiceDecoder {
    
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
    
    func fetchTranslationData(textToTranslate: String, completion: @escaping(Result<MainTranslationInfo, ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        guard let baseUrl = baseUrl, let googleUrl = URL(string: "\(baseUrl)?key=\(APIKeys.googleTranslateKey)&target=en&q=\(textToTranslate)&source=fr") else {
            return completion(.failure(.invalidUrl))
        }
        urlSessionDataTask?.cancel()
        urlSessionDataTask = urlSession.dataTask(with: googleUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainTranslationInfo.self, data: data, response: response, error: error)
            completion(result)
        })
        urlSessionDataTask?.resume()
    }
}

