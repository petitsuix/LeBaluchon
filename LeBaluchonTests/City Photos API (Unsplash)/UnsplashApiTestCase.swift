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
    
    func testGetCurrencyShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let photoService = UnsplashApi(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil)
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
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given :
        let photoService = UnsplashApi(
            urlSession: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseKO, error: nil)
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
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        let photoService = UnsplashApi(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
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
    
    func testGetCurrencyShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let photoService = UnsplashApi(
            urlSession: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        photoService.fetchWeatherPhotoData(collectionId: "https://api.unsplash.com/collections/3541178/photos/?client_id=nLJumqeaMtCuWU558JLsNHtBzT5V1qhlQIgOiq-ysok") { (result) in
            let raw = "https://images.unsplash.com/photo-1560708219-ba2b13ed6c6e?ixid=MnwyMjM0NzJ8MHwxfGNvbGxlY3Rpb258MXw0MjY4MDR8fHx8fDJ8fDE2MTkxODY4NTA&ixlib=rb-1.2.1"
            // Then :
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(raw, success[0].urls.raw)
        }
    }
}
