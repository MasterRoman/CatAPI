//
//  UserManager.swift
//  CatAPI
//
//  Created by Admin on 28.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import Foundation


class UserManager: NSObject {
    
    override init() {
        
    }
    
    func checkUserLogin(login : String)->Bool{
        
        return false 
    }
    
    func checkUserRegistration(login : String,password : String) ->Bool{
       
        return false
    }
    
    func registerUser(login : String,password : String,apiKey : String,isActive : Bool){
        
    }
    
}
