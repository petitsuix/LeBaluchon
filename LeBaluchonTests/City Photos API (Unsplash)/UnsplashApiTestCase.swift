//
//  UnsplashApiTestCase.swift
//  LeBaluchonTests
//
//  Created by Richardier on 23/04/2021.
//

import XCTest
@testable import LeBaluchon

class UnsplashApiTestCase: XCTestCase {
    
    func testGetCityPhotoShouldPostFailedCompletionIfError() throws {
        // Given :
        let cityPhotoService = UnsplashApi(
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )
        // When :
        cityPhotoService.fetchWeatherPhotoData(collectionId: "https://api.unsplash.com/collections/3541178/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
}
