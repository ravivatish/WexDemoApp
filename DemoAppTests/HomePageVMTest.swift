//
//  DemoAppTests.swift
//  DemoAppTests
//
//  Created by Ravi Vitash on 10/9/23.
//

import XCTest
@testable import DemoApp

final class HomePageVMTest: XCTestCase {

    func testgetCitiesNetworkCall() throws {
        
        // In this demo we have a pretty simple ViewModel, I am utilizing dependency injection to provide an input string to the VM
        // But for complex systems we can use protocols
        
        let model = HomePageViewModel(text: "Dallas")
        let expe = expectation(description: "wait for api call to finish")
        let result = XCTWaiter.wait(for: [expe], timeout: 2.0)
        if( result == XCTWaiter.Result.timedOut ) {
            if(!model.cityList.isEmpty) {
                XCTAssert(model.cityList.first!.name == "Dallas" && model.cityList.first!.state == "Texas")
            } else {
                XCTFail("Network call failed")
            }
        } else {
            XCTFail("Network call failed")
        }
    }
}
