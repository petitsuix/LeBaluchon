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
        let session = URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        // Given :
        let cityPhotoService = WeatherPhotoServiceUnsplash(
            urlSession: session, baseUrl: FakeResponseData.badUrl
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
    
    func testGetCityPhotoShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let photoService = WeatherPhotoServiceUnsplash(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil), baseUrl: "https://api.unsplash.com/collections/"
        )
        // When :
        photoService.fetchWeatherPhotoData(collectionId: "https://api.unsplash.com/collections/3541178/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCityPhotoShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given :
        let photoService = WeatherPhotoServiceUnsplash(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "Unsplash"), response: FakeResponseData.responseKO, error: nil), baseUrl: "https://api.unsplash.com/collections/"
        )
        // When :
        photoService.fetchWeatherPhotoData(collectionId: "https://api.unsplash.com/collections/3541178/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCityPhotoShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        let photoService = WeatherPhotoServiceUnsplash(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil), baseUrl: "https://api.unsplash.com/collections/"
        )
        // When :
        photoService.fetchWeatherPhotoData(collectionId: "https://api.unsplash.com/collections/3541178/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCityPhotoShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let photoService = WeatherPhotoServiceUnsplash(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "Unsplash"), response: FakeResponseData.responseOK, error: nil), baseUrl: "https://api.unsplash.com/collections/"
        )
        // When :
        photoService.fetchWeatherPhotoData(collectionId: "https://api.unsplash.com/collections/3541178/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok") { (result) in
            let regular = "https://images.unsplash.com/photo-1560708219-ba2b13ed6c6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMjM0NzJ8MHwxfGNvbGxlY3Rpb258MXw0MjY4MDR8fHx8fDJ8fDE2MTkxODY4NTA&ixlib=rb-1.2.1&q=80&w=1080"
            // Then :
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(regular, success[0].urls.regular)
        }
    }
}
