//
//  TranslationServiceGoogle.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import UIKit

class TranslationServiceGoogle: ServiceDecoder {
    
    // MARK: - Properties
    
    private var urlSessionDataTask: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    
    static let shared = TranslationServiceGoogle() // Singleton pattern. Allows to coordinate operations
    
    // MARK: - Init methods
    
    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    // MARK: - Methods
    
    private func getPersonalizedUrl(_ textToTranslate: String) -> String {
        let stringUrl = "https://translation.googleapis.com/language/translate/v2?key=\(APIKeys.googleTranslateKey)&target=en&q=\(textToTranslate)&source=fr"
        return stringUrl
    }
    
    func fetchTranslationData(textToTranslate: String, completion: @escaping(Result<MainTranslationInfo, ServiceError>) -> Void) { // Parameter completion is a Result. It induces a success or a failure
        guard let googleUrl = URL(string: getPersonalizedUrl(textToTranslate).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
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

