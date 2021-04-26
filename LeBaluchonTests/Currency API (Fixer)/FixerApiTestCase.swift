//
//  LeBaluchonTests.swift
//  LeBaluchonTests
//
//  Created by Richardier on 09/04/2021.
//

import XCTest
@testable import LeBaluchon

class FixerApiTestCase: XCTestCase {

    func testGetCurrencyShouldPostFailedCompletionIfError() throws {
        // Given :
        let currencyService = FixerApi(
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )
        // When :
        currencyService.fetchCurrencyData() { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let currencyService = FixerApi(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil)
        )
        // When :
        currencyService.fetchCurrencyData() { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given :
        let currencyService = FixerApi(
            urlSession: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseKO, error: nil)
        )
        // When :
        currencyService.fetchCurrencyData() { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        let currencyService = FixerApi(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        currencyService.fetchCurrencyData() { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let currencyService = FixerApi(
            urlSession: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        currencyService.fetchCurrencyData() { (result) in
            let base = "EUR"
            let rate = Float(1.202769)
            // Then :
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(base, success.base)
            XCTAssertEqual(rate, success.rates.USD)
        }
    }
}
