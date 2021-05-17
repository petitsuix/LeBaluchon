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
        let translationService = TranslationServiceGoogle(
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )
        // When :
        translationService.fetchTranslationData(textToTranslate: "Bonjour") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostFailedCompletionIfNoData() throws {
        // Given :
        let translationService = TranslationServiceGoogle(
            urlSession: URLSessionFake(data: nil, response: nil, error: nil)
        )
        // When :
        translationService.fetchTranslationData(textToTranslate: "Bonjour") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given :
        let translationService = TranslationServiceGoogle(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "GoogleTranslate"), response: FakeResponseData.responseKO, error: nil)
        )
        // When :
        translationService.fetchTranslationData(textToTranslate: "Bonjour") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        let translationService = TranslationServiceGoogle(
            urlSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        translationService.fetchTranslationData(textToTranslate: "Bonjour") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given :
        let translationService = TranslationServiceGoogle(
            urlSession: URLSessionFake(data: FakeResponseData.getCorrectDataFor(resource: "GoogleTranslate"), response: FakeResponseData.responseOK, error: nil)
        )
        // When :
        translationService.fetchTranslationData(textToTranslate: "Bonjour") { (result) in
            let translatedText = "Hello"
            // Then :
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(translatedText, success.data.translations[0].translatedText)
        }
    }
}
