//
//  GoogleTranslateApiTestCase.swift
//  LeBaluchonTests
//
//  Created by Richardier on 23/04/2021.
//

import XCTest
@testable import LeBaluchon

class GoogleTranslateApiTestCase: XCTestCase {
    
    func testGetTranslationShouldPostFailedCompletionIfError() throws {
        // Given :
        let translationService = GoogleTranslateApi(
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )
        // When :
        translationService.fetchTranslationData("Bonjour") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
}
