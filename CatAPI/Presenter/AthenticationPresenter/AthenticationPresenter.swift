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
    private var userManager : UserManager!
    override init() {
        self.userManager = UserManager.init()
    }
    
    func setAthenticationalViewDelegate(view:AthenticationDelegateProtocol) {
        self.athenticationalDelegate = view;
    }
    
    func checkUser(login:String,password:String) {
       // working with User Maneger
        let user : Bool = self.userManager.checkUserRegistration(login: login, password: password)
        if (user) {
            //push registered user
            self.athenticationalDelegate?.pushRegisteredUser()
        }
        else {
            self.athenticationalDelegate?.showWrongLoginOrPassword()
           // wrong login or password
        }
          
    }
    
    
    
    // MARK: Delegate methods
    
    
    func showMainVCWithoutRegistration() {
        self.athenticationalDelegate?.showUnregisterMainController()
    }
    
    func showRegistrationViewController()  {
        self.athenticationalDelegate?.pushRegistrationVC()
        
    }
    
    func autoAuthenticateUser() -> Bool {
        return self.userManager.checkUserStatus()
    }
    
    
    
    
    
    

}
