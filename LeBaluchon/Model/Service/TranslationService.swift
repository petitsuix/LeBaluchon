//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import UIKit

class APITranslation {
    
    var completion: ((_ result: MainTranslationInfo?, _ error: String?) -> Void)?
    
    func getPersonalizedUrl(_ textToTranslate: String) -> String {
    let stringUrl = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBpDSTXoUFEhOtTpSTyi9syvijoeDsXF7I&target=en&q=\(textToTranslate)&source=fr"
        return stringUrl
    }
    
    func start(_ textToTranslate: String, completion: ((_ result: MainTranslationInfo?, _ error: String?) -> Void)?) {
        self.completion = completion
        guard let googleTransUrl = URL(string: getPersonalizedUrl(textToTranslate).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { completion?(nil, "Mauvaise URL"); return }
        URLSession.shared.dataTask(with: googleTransUrl, completionHandler: response).resume()
        print("\(googleTransUrl)")
    }
    
    func response(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        
        if let error = error {
            completion?(nil, "error fetching data")
            // completionHandler
            print("error fetching data: \(error.localizedDescription)")
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion?(nil, ServiceError.invalidResponse.localizedDescription)
            return
        }
        
        guard response.statusCode == 200 else { // ça peut être d'autre status code valides (d'autres codes)
            completion?(nil, ServiceError.invalidStatusCode.localizedDescription)
            return
        }
        
        guard let data = data else {
            print("empty data")
            completion?(nil, ServiceError.emptyData.localizedDescription)
            return
        }
        print("\(data)")
        DispatchQueue.main.async {
            do {
                let decodedData = try JSONDecoder().decode(MainTranslationInfo.self, from: data)
                self.completion?(decodedData, nil)
            } catch let error {
                self.completion?(nil, error.localizedDescription)
                print("decoding error: \(error.localizedDescription)")
                print("\(error)")
            }
        }
    }
}

