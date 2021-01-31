//
//  URLSessionMock.swift
//  CatAPITests
//
//  Created by Admin on 28.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    
    var data : Data?
    var response : URLResponse?
    var error : Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let mockDataTask = URLSessionDataTaskMock.init(with: {
            completionHandler(self.data,nil,self.error)
        })
        return mockDataTask
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let mockDataTask = URLSessionDataTaskMock.init(with: {
            completionHandler(self.data,nil,self.error)
        })
        return mockDataTask
    }
}
