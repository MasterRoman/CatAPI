//
//  NetworkManager.swift
//  CatAPI
//
//  Created by Admin on 05.11.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    
    private var chache : NSCache<NSString,UIImage>
    private let parser : JSONParser
    private var session : URLSession
    private var operations : Dictionary<String,Array<DownloadImageOperation>>
    private var queue : OperationQueue
    
    init(withParser parser:JSONParser) {
        self.parser = parser
        self.chache = NSCache.init()
        self.session = URLSession.init(configuration: .default)
        self.operations = Dictionary.init()
        self.queue = OperationQueue.init()
    }
    
    func loadCats(url:String,completion:@escaping (Result<Array<CatModel>,Error>)->()){
        let url : URL =  URL(string: url)!
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
        self.operations[url] = [imageOperation]
        imageOperation.completion = { image in
            completion(image)
        }
        self.queue.addOperation(imageOperation)
    
    }
    
    func cancelDownloadingForUrl(url:String)  {
        if let existingOperations = self.operations[url]{
            for operation in existingOperations {
                operation.cancel()
            }
        }
        else
        { return; }
        
        
    }
    
    func getChachedImage(for url:String,completion:@escaping (Result<UIImage,Error>)->()){
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            guard let self = self else {return}
            
            let image : UIImage? = self.chache.object(forKey: url as NSString)
            if ((image) != nil){
                completion(.success(image!))
            }
            else
            {
                let placeholder = UIImage.init(named: "cat")
                completion(.success(placeholder!))
                self.loadImageForUrl(url: url, completion: { image in
                    self.chache.setObject(image, forKey: url as NSString)
                    completion(.success(image))
                })
            }
            
            
        }
    }
    
    
    
}
