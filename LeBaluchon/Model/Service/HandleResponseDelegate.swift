//
//  HandleResponseDelegate.swift
//  LeBaluchon
//
//  Created by Richardier on 21/04/2021.
//

import Foundation

class HandleResponseDelegate {
    
    func handleResponse<T>(dataType: T.Type,_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<T, ServiceError> where T: Decodable {
        
        if let error = error {
            return .failure(.errorFromApi(error.localizedDescription)) // .APIError
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }
        
        guard response.statusCode == 200 else { // ça peut être d'autre status code valides (d'autres codes)
            return .failure(.invalidStatusCode)
        }
        
        guard let data = data else {
            return .failure(.emptyData)
        }
        do {
            let decodedData = try JSONDecoder().decode(dataType, from: data)
            return .success(decodedData)
        } catch let error {
            print("\(error)")
            return .failure(.decodingError)
        }
    }
}
