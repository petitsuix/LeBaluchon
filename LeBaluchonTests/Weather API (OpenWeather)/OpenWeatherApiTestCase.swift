//
//  OpenWeatherApiTestCase.swift
//  LeBaluchonTests
//
//  Created by Richardier on 23/04/2021.
//


// tests : on controle la logique du code
// on couvre tous les cas d'usage (qd ça marche ou pas, etc.)
// -> là on parle du fake avant de rentrer dans les détils des tests

import XCTest
@testable import LeBaluchon

class OpenWeatherApiTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCompletionIfError() throws {
        // Given :
        let weatherService = OpenWeatherService( // Creating an instance of OpenWeather API that takes an URLSessionFake as parameter
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error) // dependency injection
        )
        // When :
        weatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil) // No data
        )
        // When :
        weatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "OpenWeather"), response: FakeResponseData.responseKO, error: nil)
        )
        // When :
        weatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        weatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "OpenWeather"), response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        weatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { (result) in
            // Then :
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(success.main.temp, Float(8.02))
            XCTAssertEqual(success.weather[0].description, "ciel dégagé")
            XCTAssertEqual(success.weather[0].icon, "01d")
        }
    }
}
