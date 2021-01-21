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
            let image : UIImage? = self.chache.object(forKey: url as NSString)
            if ((image) != nil){
                completion(.success(image!))
            }
            else
            {
                let placeholder = UIImage.init(named: "cat")
                completion(.success(placeholder!))
                self.loadImageForUrl(url: url, completion: { [weak self] image in
                    guard let self = self else {return}
                    self.chache.setObject(image, forKey: url as NSString)
                    completion(.success(image))
                })
            }
    }
    
    func loadUplodedCats(for url:String,apiKey : String,completion:@escaping (Result<Array<CatModel>,Error>)->()){
        
        let url = URL(string: url)
        let headers : Dictionary = ["x-api-key":apiKey]
        var request : URLRequest = URLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask : URLSessionDataTask = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil){
                completion(.failure(error!))
                return
            }
            
            if (data != nil){
                self.parser.parseCats(data: data, completion: completion)
            }
            else
            {
                return;
            }
            
        })
        
        dataTask.resume()
    }
    
    func uploadImage(for apiKey:String,fileName : String,image : UIImage,completion:@escaping (Result<Array<CatModel>,Error>)->()){
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        let strContentType = "multipart/form-data; boundary=\(boundary)"
        let headers : Dictionary = ["Content-Type": strContentType ,"x-api-key":apiKey]
        
        let url = URL(string: "https://api.thecatapi.com/v1/images/upload")
        
        var request : URLRequest = URLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
     

        var httpBody : Data = Data()
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
       
      // let extansion : String = fileName.components(separatedBy: ".").last!
      //  let str = String.init(format: "Content-Type: image/%@\r\n\r\n", extansion)
        
        //work only with jpeg
        httpBody.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        
        httpBody.append(image.jpegData(compressionQuality: 0.7)!)
        httpBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
        
        request.httpBody = httpBody
       
        
        
        let dataTask : URLSessionDataTask = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil){
                completion(.failure(error!))
                return
            }
            
           
            
        })
        
        dataTask.resume()
        
        
    }
    
    
    
}
