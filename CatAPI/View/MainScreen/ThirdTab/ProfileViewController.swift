//
//  ProfileViewController.swift
//  CatAPI
//
//  Created by Admin on 21.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,ProfileViewDelegateProtocol {
  


    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var apiKeyTextFField: UITextField!
    
    private var presenter : ProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = ProfilePresenter.init()
        self.presenter!.setProfileViewDelegate(view: self)
        
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter!.checkUserStatus()
    }
    
    func setUpView(){
    

        self.loginTextField.isUserInteractionEnabled = false
        self.passwordTextField.isUserInteractionEnabled = false
        self.apiKeyTextFField.isUserInteractionEnabled = false
        
    }

    
    // MARK: - Delegate methods
    
    func showAlertController() {
        
    }
    
    func changeProfileValues() {
        
    }
    
    func checkUserStatus() {
        let dict : Dictionary = self.presenter!.checkUserParameters()
        self.loginTextField.text = dict["Login"] as? String
        self.passwordTextField.text = dict["Password"] as? String
        self.apiKeyTextFField.text = dict["ApiKey"] as? String
        
    }
    

    

}
