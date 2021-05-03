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
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
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
    
    func testGetCurrencyShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil)
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
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectResponse() throws {
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
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectData() throws {
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
    
    func testGetCurrencyShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let weatherService = OpenWeatherService(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "OpenWeather"), response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        weatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { (result) in
            let temp = Float(8.02)
            let description = "ciel dégagé"
            let icon = "01d"
            // Then :
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(temp, success.main.temp)
            XCTAssertEqual(description, success.weather[0].description)
            XCTAssertEqual(icon, success.weather[0].icon)
        }
    }
}
