//
//  AthenticationDelegateProtocol.swift
//  CatAPI
//
//  Created by Admin on 28.10.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import Foundation


protocol AthenticationDelegateProtocol : class {
    func showUnregisterMainController()
    func pushRegistrationVC()
    func pushRegisteredUser()
    func showWrongLoginOrPassword()
}
