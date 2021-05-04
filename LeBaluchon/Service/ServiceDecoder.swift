//
//  HandleResponseDelegate.swift
//  LeBaluchon
//
//  Created by Richardier on 21/04/2021.
//

import Foundation

class ServiceDecoder {
    
    func handleResponse<T>(dataType: T.Type, _ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<T, ServiceError> where T: Decodable {
        
        if let error = error {
            return .failure(.errorFromApi(error.localizedDescription))
        }
        
        guard let response = response as? HTTPURLResponse else { // HTTPURLResponse provides methods for accessing information specific to HTTP protocol responses, such as ".statusCode" below
            return .failure(.invalidResponse)
        }
        
        guard response.statusCode == 200 else {
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
