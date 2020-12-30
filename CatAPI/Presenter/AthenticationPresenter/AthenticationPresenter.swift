//
//  AthenticationPresenter.swift
//  CatAPI
//
//  Created by Admin on 31.10.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class AthenticationPresenter: NSObject {
    var athenticationalDelegate : AthenticationDelegateProtocol?
    
    override init() {
        
    }
    
    func setAthenticationalViewDelegate(view:AthenticationDelegateProtocol) {
        self.athenticationalDelegate = view;
    }
    
    func checkUser(login:String,password:String) {
        //working with User Maneger
//        let user : Bool? // =
//        if let curUser = user {
//            push registered user
//            //
//        }
//        else {
            self.athenticationalDelegate?.showWrongLoginOrPassword()
            //wrong login or password
//        }
          
    }
    
    
    
    // MARK: Delegate methods
    
    
    func showMainVCWithoutRegistration() {
        self.athenticationalDelegate?.showUnregisterMainController()
    }
    
    func showRegistrationViewController()  {
        self.athenticationalDelegate?.pushRegistrationVC()
        
    }
    
    func autoAuthenticateUser() -> Bool {
        //working with User Maneger
        return true;
    }
    
    
    
    
    
    

}
