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

    func testLoadingImage() throws{
        let localImage : UIImage = UIImage.init(named: "cat")!
        let filePath : String = Bundle(for: type(of: self)).path(forResource: "cat.png", ofType: nil)!
        
        self.networkManager?.loadImageForUrl(url: filePath, completion: { (image) in
            XCTAssertEqual(localImage, image)
        })
        
        self.networkManager?.loadImageForUrl(url: filePath, completion: { (image) in
            XCTAssertEqual(localImage, image)
        })
        
    }
    
    func testChaching() throws {
        let localImage : UIImage = UIImage.init(named: "cat")!
        let catImage : UIImage = UIImage.init(named: "cat_selected")!
        let filePath : String = Bundle(for: type(of: self)).path(forResource: "animal-footprint.png", ofType: nil)!
        self.networkManager = NetworkManagerMock.init(withParser: self.parser!)
        
        var numberOfReceiving = 0
        
        self.networkManager?.getChachedImage(for: filePath, completion: { result in
            switch result{
            case .success(let image):
                if (numberOfReceiving == 0){
                    XCTAssertEqual(localImage, image)   //receive placeholder
                    numberOfReceiving += 1
                }
                else {
                    XCTAssertEqual(catImage, image)  // necessary image
                }
                
            case .failure(_):
                break
            }
            
        })
        
        //get from chache from chache without downloading
        self.networkManager?.getChachedImage(for: filePath, completion: { result in
            switch result{
            case .success(let image):
                XCTAssertEqual(catImage, image)
            case .failure(_):
                break
            }
            
        })
    }
    
    
    func testLoadingUplodedCats() throws {
        
        let filePath = Bundle(for: type(of: self)).path(forResource: "MockJson", ofType: nil)
        let url = "https://Someurl"
        let apiKey = "Some api"
        
        let mockData = NSData.init(contentsOfFile: filePath!)
        self.mockSession?.data = mockData as Data?
        self.networkManager?.session = self.mockSession!
        
        self.networkManager?.loadUplodedCats(for: url, apiKey: apiKey, completion: { result in
            switch result{
            case .success(let array):
                XCTAssertTrue(array.count == 2)
            case .failure(_):
                break
            }
            
        })
        
        let mockError = NSError(domain: "mock", code: 0, userInfo: nil)
        self.mockSession?.error = mockError as Error
        
        self.networkManager?.loadUplodedCats(for: url, apiKey: apiKey, completion: { result in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error.self.localizedDescription)
            }
            
        })
        
       
        
        self.mockSession?.data = nil
        self.mockSession?.error = nil
        //exit because of absense of date 
        self.networkManager?.loadUplodedCats(for: url, apiKey: apiKey, completion: { _ in
    
        })
    }
    
    
    func testUploadingImage() throws{
        
        let filePath = Bundle(for: type(of: self)).path(forResource: "MockJsonForDictionary", ofType: nil)
        let url = "https://Someurl"
        let fileName = "Somefile"
        let image = UIImage.init(named: "cat")
        
        let mockString = try String(contentsOfFile: filePath!)
        let mockData : Data = mockString.data(using: .utf8)!
        
        self.mockSession?.data = mockData 
        self.networkManager?.session = self.mockSession!
        
        self.networkManager?.uploadImage(for: url, fileName: fileName, image: image!, completion: { result in
            switch result{
            case .success(let dict):
                XCTAssertEqual(dict["url"] as! String, "https://cdn2.thecatapi.com/images/MTYxMjc1OQ.jpg")
            case .failure(_):
                break
            }
            
        })
        
        self.mockSession?.data = Data.init()
        
        self.networkManager?.uploadImage(for: url, fileName: fileName, image: image!, completion: { result in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error.self.localizedDescription)
            }
            
        })
        
        let mockError = NSError(domain: "mock", code: 0, userInfo: nil)
        self.mockSession?.error = mockError as Error
        
        self.networkManager?.uploadImage(for: url, fileName: fileName, image: image!, completion: { result in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error.self.localizedDescription)
            }
            
        })
        
    }
    
    func testDeletingUplodedImageFromServer() throws{
        
        let imageId = "SomeId"
        let apiKey = "Some api"
        
        self.networkManager?.session = self.mockSession!
        
        let promise = expectation(description: "handeler")
        self.networkManager?.deleteUplodedImageFromServer(for: apiKey, imageId: imageId, completion: { result in
            switch result{
            case .success(let str):
                XCTAssertEqual(str, "Deleted")
                promise.fulfill()
            case .failure(_):
                break
            }
            
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
        let mockError = NSError(domain: "mock", code: 0, userInfo: nil)
        self.mockSession?.error = mockError as Error
        
        //error
        self.networkManager?.deleteUplodedImageFromServer(for: apiKey, imageId: imageId, completion: { result in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error.self.localizedDescription)
            }
            
        })
    }
    
    
}


