//
//  JSONParser.swift
//  CatAPI
//
//  Created by Admin on 05.11.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class JSONParser: NSObject {
    
    func parseCats(data:Data?,completion:@escaping (Result<Array<CatModel>,Error>) -> ()){
        
        if (data == nil){
            //completion(.failure(error))
            return
        }
       
        var rootDictionary : [Dictionary<String,Any>]?
        
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String,Any>] else
            {
                //completion(.failure())
                return
            }
            rootDictionary = dict
        } catch {
            completion(.failure(error))
        }
       
        if (rootDictionary == nil){
            //completion(.failure())
            return
        }
        
      
        var cats : Array<CatModel> = []
        if let dict = rootDictionary{
            for item in dict{
                cats.append(CatModel.init(withDictionary: item))
            }
        }
        completion(.success(cats))
            
    }

}
