//
//  NetworkManager.swift
//  CatAPI
//
//  Created by Admin on 05.11.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
   
    
    
    var chache : NSCache<AnyObject,UIImage>
    private let parser : JSONParser
    private var session : URLSession
    private var operations : Dictionary<String,Array<Operation>>
    private var queue : OperationQueue
    
    init(withParser parser:JSONParser) {
        self.parser = parser
        self.chache = NSCache.init()
        self.session = URLSession.init(configuration: .default)
        self.operations = Dictionary.init()
        self.queue = OperationQueue.init()
    }
    
    func loadCats(url:String,completion:@escaping (Result<Array<CatModel>,Error>)->()){
        let url : URL =  URL.init(fileURLWithPath: url)
        let dataTask : URLSessionDataTask = self.session.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                completion(.failure(error!))
                return
            }
            self.parser.parseCats(data: data, completion: completion)
        }
        dataTask.resume()
    }
    
    func loadImageForUrl(url:String,completion:@escaping (UIImage )->()){
        //cancel operation
        cancelDownloadingForUrl(url: url)
        let imageOperation : DownloadImageOperation = DownloadImageOperation.init(withUrl: url)
        self.operations[url] = Array.init(arrayLiteral: imageOperation)
        imageOperation.completion = { image in
            completion(image)
        }
        self.queue.addOperation(imageOperation)
    
    }
    
    func cancelDownloadingForUrl(url:String)  {
        let operations : Array<Operation>? = self.operations[url]
        if let newOperations = operations{
            for operation : Operation in newOperations {
                operation.cancel()
            }
        }
        else
        { return; }
        
        
    }
    
    

}
