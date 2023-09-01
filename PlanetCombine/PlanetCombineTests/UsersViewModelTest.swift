//
//  UsersViewModelTest.swift
//  PlanetCombineTests
//
//  Created by Consultant on 8/1/23.
//

import XCTest
@testable import PlanetCombine

final class UsersViewModelTest: XCTestCase {

    var userViewModel: UsersViewModel!

    @MainActor override func setUpWithError() throws {
        userViewModel = UsersViewModel(networkManager: FakeNetworkManager())
    }

    override func tearDownWithError() throws {
       userViewModel = nil
    }

    func testAPICallForPerfectConditions() throws {
        userViewModel.getPlanetsFromAPI(urlString: "UsersMockTest")
        
        let expectation = XCTestExpectation(description: "Fetching Planet List")
        let waitDuration = 3.0
        
        DispatchQueue.main.async{
            XCTAssertNotNil(self.userViewModel)
            XCTAssertEqual(self.userViewModel.result.count, 10)
            XCTAssertNil(self.userViewModel.customError)
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: waitDuration)
    }

     func testAPICallFailure() throws {
        userViewModel.getPlanetsFromAPI(urlString: "asff")
        
        let expectation = XCTestExpectation(description: "Fetching Users list")
        let waitDuration = 3.0
        
        DispatchQueue.main.async{
            XCTAssertNotNil(self.userViewModel)
            XCTAssertEqual(self.userViewModel.result.count, 0)
            XCTAssert((self.userViewModel.customError != nil))
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: waitDuration)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

