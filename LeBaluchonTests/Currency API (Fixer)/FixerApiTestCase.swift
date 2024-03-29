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
        let session = URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        // Given :
        let currencyService = CurrencyServiceFixer(urlSession: session, baseUrl: FakeResponseData.badUrl)
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
        let currencyService = CurrencyServiceFixer(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil), baseUrl: "http://data.fixer.io/api/latest"
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
        let currencyService = CurrencyServiceFixer(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "Fixer"), response: FakeResponseData.responseKO, error: nil), baseUrl: "http://data.fixer.io/api/latest"
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
        let currencyService = CurrencyServiceFixer(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil), baseUrl: "http://data.fixer.io/api/latest"
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
        let currencyService = CurrencyServiceFixer(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "Fixer"), response: FakeResponseData.responseOK, error: nil), baseUrl: "http://data.fixer.io/api/latest"
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
