//
//  AthenticationViewController.swift
//  CatAPI
//
//  Created by Admin on 28.10.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit




class AthenticationViewController: UIViewController,AthenticationDelegateProtocol {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var stackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var showCatsButton: UIButton!
    
    
    private var presenter : AthenticationPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = AthenticationPresenter.init()
        setUpView()
        self.presenter.setAthenticationalViewDelegate(view: self)
        calculateLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let autoAthentication : Bool = self.presenter!.autoAuthenticateUser()
        if (autoAthentication){
            self.presenter!.showMainVCWithoutRegistration()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        calculateLayout()
        
    }
    
   // MARK: actions
    
    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        self.presenter.checkUser(login: self.loginTextField.text!, password: self.passwordTextField.text!)
    }
    
    @IBAction func showCatsButtonDidPress(_ sender: UIButton) {
        self.presenter.showMainVCWithoutRegistration()
    }
    
    
    @IBAction func registerButtonDidPress(_ sender: UIButton) {
        self.presenter.showRegistrationViewController()
    }
    
    
    @IBAction func logitTextFieldDidEdit(_ sender: UITextField) {
        if ((!(sender.text!.isEmpty)) && (!(self.passwordTextField.text!.isEmpty))){
            self.loginButton.isEnabled = true
            self.loginButton.alpha = 1.0
        } else {
            self.loginButton.isEnabled = false
            self.loginButton.alpha = 0.5
        }
        
    }
    
    @IBAction func passwordTextFieldDidEdit(_ sender: UITextField) {
        if ((!(sender.text!.isEmpty)) && (!(self.loginTextField.text!.isEmpty))){
            self.loginButton.isEnabled = true
            self.loginButton.alpha = 1.0
        } else {
            self.loginButton.isEnabled = false
            self.loginButton.alpha = 0.5
        }
    }
    
    
    // MARK:Layout setUp
    
    func calculateLayout(){
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height){
            self.stackViewWidthConstraint.constant = 250
        } else {
            self.stackViewWidthConstraint.constant = 175
        }
    }
    
    func setUpView(){
        self.loginButton.isEnabled = false
        self.loginButton.alpha = 0.5
    }
    
    
    
    
    // MARK:Delegate methods
    
    func showUnregisterMainController() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            let tabBarVC : MainTabBarController = MainTabBarController.init()
            
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }
    
    func pushRegistrationVC() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            let registrationVC : RegistrationViewController = RegistrationViewController.init()
            
            self.navigationController?.present(registrationVC, animated: true, completion: nil)
        }
        
    }
    
    func pushRegisteredUser() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            let tabBarVC : MainTabBarController = MainTabBarController.init()
            
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
        
    }
    
    func showWrongLoginOrPassword() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            let alert : UIAlertController = UIAlertController.init(title: "Wrong data", message: "Wrong login or password", preferredStyle: .alert)
            let alertAction : UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}
