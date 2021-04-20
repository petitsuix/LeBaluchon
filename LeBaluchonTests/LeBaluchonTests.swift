//
//  LeBaluchonTests.swift
//  LeBaluchonTests
//
//  Created by Richardier on 09/04/2021.
//

import XCTest
@testable import LeBaluchon

class LeBaluchonTests: XCTestCase {

    var currency: APICurrency!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        currency = APICurrency()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        currency = nil
    }

    func testGivenLyonWeather_WhenUpdatingUI_ThenWeatherIconLoads() {
        // Given :
        
    }
    
    
    
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
