//
//  DownloadImageOperation.swift
//  CatAPI
//
//  Created by Admin on 22.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class DownloadImageOperation: Operation {
    
    private var url : String;
    var dataTask : URLSessionDataTask?
    var completion : ( (_ image : UIImage) -> (Void))?
    var image : UIImage?
    
    init(withUrl url:String) {
        self.url = url
        
    }
    
    override func main() {
        
        if self.isCancelled{
            return;
        }
       
        let url : URL = URL(string: self.url)!
        self.dataTask = URLSession.shared.dataTask(with: url, completionHandler:{ [weak self] data,response,error in
            guard let self = self else {return}
            if (self.isCancelled){
                return;
            }
            if (data == nil) { return }
            if (self.isCancelled){
                return;
            }
            let image : UIImage = UIImage.init(data: data!)!
            
            self.image = image
            if (self.completion != nil) {
                self.completion!(image)
            }
            else {
                return
            }
            }
        )
        
        if self.isCancelled{
            return
        }
        self.dataTask?.resume();
    }
    
    override func cancel() {
        super.cancel()
        self.dataTask?.cancel()
    }
    
}
