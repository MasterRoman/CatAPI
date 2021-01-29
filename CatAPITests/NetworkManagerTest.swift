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
    private var mockSession : URLSessionMock?


    override func setUpWithError() throws {
        self.parser = JSONParser.init()
        self.networkManager = NetworkManager.init(withParser: self.parser!)
        self.mockSession = URLSessionMock.init()
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        self.parser = nil
        
    }
    
   
    func testLoadingAndParsingCats() throws {
        let filePath = Bundle(for: type(of: self)).path(forResource: "MockJson", ofType: nil)
        let mockData = NSData.init(contentsOfFile: filePath!)
        self.mockSession?.data = mockData as Data?
        self.networkManager?.session = self.mockSession!
        self.networkManager?.loadCats(url: filePath!, completion: {result in
            switch result{
            case .success(let array):
                XCTAssertTrue(array.count == 2)
            case .failure(_):
                break
            }
        })
        
        self.mockSession?.data = Data.init()
        let url = "inccorrectURL"
        self.networkManager?.loadCats(url: url, completion: { result in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error.self.localizedDescription)
            }
            
        })
        
    }

  

}
