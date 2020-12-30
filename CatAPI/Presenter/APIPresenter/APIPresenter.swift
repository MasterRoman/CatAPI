//
//  APIPresenter.swift
//  CatAPI
//
//  Created by Admin on 30.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import Foundation

class APIPresenter: NSObject {
    private var apiDelegate : APIDelegateProtocol?
    private var userManeger : UserManager?
   
    override init() {
        self.userManeger = UserManager.init()
    }
    
    func setAPIViewDelegate(view : APIDelegateProtocol){
        self.apiDelegate = view
    }
   
    func registerUserAndPushMainVC(login : String!,password : String!,apiKey : String!){
        //self.userManager registerUser:login password:password apiKey:apiKey isActive:isActive];
        self.apiDelegate?.pushMainVC()
    }

    func showApiWebPage() {
        self.apiDelegate?.showAPIWebPage()
    }
    
}
