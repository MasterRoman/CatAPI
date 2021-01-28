//
//  NetworkManagerTest.swift
//  CatAPITests
//
//  Created by Admin on 28.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import XCTest

@testable import CatAPI


class NetworkManagerTest: XCTestCase {
    
    private var parser : JSONParser?
    private var networkManager : NetworkManager?


    override func setUpWithError() throws {
        self.parser = JSONParser.init()
        self.networkManager = NetworkManager.init(withParser: self.parser!)
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        self.parser = nil
        
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
