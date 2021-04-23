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
}
