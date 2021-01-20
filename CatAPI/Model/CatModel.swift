//
//  CatModel.swift
//  CatAPI
//
//  Created by Admin on 05.11.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class CatModel: NSObject {
    
    var imageId : String
    var url : String
    
    init(withDictionary dictionary:NSDictionary) {
        self.imageId = dictionary["id"] as! String
        self.url = dictionary["url"] as! String
    }
    
    init(with url:String){
        self.url = url
        self.imageId = ""
    }
    
}
