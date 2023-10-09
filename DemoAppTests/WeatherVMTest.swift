//
//  WeatherVMTest.swift
//  DemoAppTests
//
//  Created by Ravi Vitash on 10/9/23.
//

import XCTest
@testable import DemoApp

final class WeatherVMTest: XCTestCase {
    
    func testWeatherVMNetworkAPiTest() throws {
        let model = WeatherViewModel(city: CityData(name: "Dallas", state: "Texas", country: "USA", lat: "32.77", lon: "-96.79"))
        let expe = expectation(description: "wait for api call to finish")
        let result = XCTWaiter.wait(for: [expe], timeout: 2.0)
        if( result == XCTWaiter.Result.timedOut ) {
            XCTAssert(model.lowTemp <= model.temperature &&
                      model.temperature <= model.hightTemp)
        } else {
            XCTFail("Network call failed")
        }
    }
}
