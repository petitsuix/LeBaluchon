//
//  OpenWeatherApiTestCase.swift
//  LeBaluchonTests
//
//  Created by Richardier on 23/04/2021.
//


// tests : on controle la logique du code
// on couvre tous les cas d'usage (qd ça marche ou pas, etc.)

import XCTest
@testable import LeBaluchon

class OpenWeatherApiTestCase: XCTestCase {
    
    // ⬇︎ Fail if error
    func testGetWeatherShouldPostFailedCompletionIfError() throws {
        let session = URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: session, baseUrl: FakeResponseData.badUrl // dependency injection, error
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
    
    // ⬇︎ Fail if no data
    func testGetWeatherShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil), baseUrl: "https://api.openweathermap.org/data/2.5/weather" // dependency injection, no data
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
    
    // ⬇︎ Fail if correct data but incorrect response
    func testGetWeatherShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "OpenWeather"), response: FakeResponseData.responseKO, error: nil), baseUrl: "https://api.openweathermap.org/data/2.5/weather" // dependency injection, correct data but incorrect response
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
    
    // ⬇︎ Fail if correct response but incorrect data
    func testGetWeatherShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil), baseUrl: "https://api.openweathermap.org/data/2.5/weather"
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
    
    // ⬇︎ Success if correct data & no error
    func testGetWeatherShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "OpenWeather"), response: FakeResponseData.responseOK, error: nil), baseUrl: "https://api.openweathermap.org/data/2.5/weather"
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
