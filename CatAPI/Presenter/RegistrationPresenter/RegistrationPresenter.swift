//
//  RegistrationPresenter.swift
//  CatAPI
//
//  Created by Admin on 28.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import Foundation


class RegistrationPresenter: NSObject {
    private var registrationDelegate : RegistrationDelegateProtocol?
    private let userManager : UserManager
    override init() {
        userManager = UserManager.init()
    }
    
    func setRegistationViewDelegate(view : RegistrationDelegateProtocol){
        self.registrationDelegate = view
    }
    
    func checkUserEnteredLogin(userLogin : String?){
        if let localLogin = userLogin{
            let user : Bool  = userManager.checkUserLogin(login:localLogin)
            if (user){
                self.registrationDelegate?.showAlertOfExisting()
            } else
            {
                self.registrationDelegate?.closeVC()
                self.registrationDelegate?.showApiEnteranceVC()
            }
        }
        else
        {
            //push alert
        }
    }
}
