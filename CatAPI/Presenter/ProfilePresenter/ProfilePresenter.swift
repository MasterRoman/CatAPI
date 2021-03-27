//
//  ProfilePresenter.swift
//  CatAPI
//
//  Created by Admin on 21.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class ProfilePresenter: NSObject {
    
    weak private var profileDelegate : ProfileViewDelegateProtocol?
    
    private var userManeger : UserManager?
    
    
    override init() {

        self.userManeger = UserManager.init()
        
    }
    
    func setProfileViewDelegate(view : ProfileViewDelegateProtocol){
        self.profileDelegate = view
    }
    
    func checkUserStatus(){
        let isActive : Bool = self.userManeger!.checkUserStatus()
        if (isActive){
            self.profileDelegate!.checkUserStatus()
        }else {
            self.profileDelegate!.showAlertController()
        }
        
    }
    
    func checkUserParameters()->Dictionary<String, Any>{
        return (self.userManeger!.getUserInfo())!
    }
    
    func logOut(){
        self.userManeger!.logOut()
    }

}
