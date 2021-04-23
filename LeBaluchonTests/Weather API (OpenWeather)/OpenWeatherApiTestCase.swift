//
//  OpenWeatherApiTestCase.swift
//  LeBaluchonTests
//
//  Created by Richardier on 23/04/2021.
//


import XCTest
@testable import LeBaluchon

class OpenWeatherApiTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCompletionIfError() throws {
        // Given :
        let weatherService = OpenWeatherApi(
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )
        // When :
        weatherService.fetchWeatherData(cityId: weatherService.newyorkId) { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
}
