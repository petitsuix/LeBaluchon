//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import UIKit

class APITranslation: HandleResponseDelegate {
    
    func getPersonalizedUrl(_ textToTranslate: String) -> String {
    let stringUrl = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBpDSTXoUFEhOtTpSTyi9syvijoeDsXF7I&target=en&q=\(textToTranslate)&source=fr"
        return stringUrl
    }
    
    func fetchTranslationData(_ textToTranslate: String, completion: @escaping(Result<MainTranslationInfo, ServiceError>) -> Void) {
        
        guard let googleUrl = URL(string: getPersonalizedUrl(textToTranslate).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            return completion(.failure(.invalidUrl))
        }
        URLSession.shared.dataTask(with: googleUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: MainTranslationInfo.self, data, response, error)
            completion(result)
        }).resume()
    }
}

