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
        if ((UserDefaults.standard.object(forKey: "Users")) != nil){
            let users : Array<Dictionary> = UserDefaults.standard.object(forKey: "Users") as! Array<Dictionary<String, Any>>
            for user in users{
                let localLogin : String = user["Login"] as! String
                if (localLogin == login){
                    return true
                }
            }
        }
        return false
    }
    
    func checkUserRegistration(login : String,password : String) ->Bool{
        if ((UserDefaults.standard.object(forKey: "Users")) != nil){
            var users : Array<Dictionary> = UserDefaults.standard.object(forKey: "Users") as! Array<Dictionary<String, Any>>
            for i in 0..<users.count {
                let user : Dictionary = users[i] as Dictionary<String, Any>
                if ((user["Login"] as! String == login) && (user["Password"] as! String == password)){
                    users[i]["IsActive"] = true
                    UserDefaults.standard.set(users, forKey: "Users")
                    return true
                }
                
            }
        }
        return false
    }
    
    func registerUser(login : String,password : String,apiKey : String,isActive : Bool){
        if ((UserDefaults.standard.object(forKey: "Users")) != nil){
            var users : Array = UserDefaults.standard.object(forKey: "Users") as! Array<Any>
            let user = ["Login": login, "Password":password, "ApiKey":apiKey, "IsActive": isActive] as [String : Any]
            users.append(user)
            UserDefaults.standard.set(users, forKey: "Users")
        }
        else {
            let user = ["Login": login, "Password":password, "ApiKey":apiKey, "IsActive": isActive] as [String : Any]
            let users = Array(arrayLiteral: user)
            UserDefaults.standard.set(users, forKey: "Users")
            
        }
        
    }
    
}

