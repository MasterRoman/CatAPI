//
//  NetworkManagerMock.swift
//  CatAPITests
//
//  Created by Admin on 31.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import Foundation
import UIKit

@testable import CatAPI

class NetworkManagerMock : NetworkManager {
    
    override func loadImageForUrl(url: String, completion: @escaping (UIImage) -> ()) {
    
        let image = UIImage.init(named: "cat_selected")!
        completion(image)
    }
    
}
