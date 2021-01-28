//
//  CatModelTest.swift
//  CatAPITests
//
//  Created by Admin on 28.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import XCTest
@testable import CatAPI

class CatModelTest: XCTestCase {

    private var dataSource : Dictionary<String, Any>?
    private var item : CatModel?
    
    override func setUpWithError() throws {
        self.dataSource = ["id":"1","url":"2"]
        self.item = CatModel.init(withDictionary: self.dataSource!)
    }

    override func tearDownWithError() throws {
         self.dataSource = nil
        self.item = nil
    }

    func testExample() throws {
        
    }

  
}
