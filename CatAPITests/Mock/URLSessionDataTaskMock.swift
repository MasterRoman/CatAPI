//
//  URLSessionDataTaskMock.swift
//  CatAPITests
//
//  Created by Admin on 28.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    
    var sessionBlock : ()->Void
    
    init(with block:@escaping ()->Void) {
        self.sessionBlock = block
    }
    
    override func resume() {
        self.sessionBlock()
    }
  
}
