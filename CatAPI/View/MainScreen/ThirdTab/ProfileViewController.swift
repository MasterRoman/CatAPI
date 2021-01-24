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
    
    @IBAction func logOutButtonDidPress(_ sender: UIButton) {
        self.presenter!.logOut()
        self.navigationController!.popViewController(animated: true)
    }
   
    func setUpView(){
    

        self.loginTextField.isUserInteractionEnabled = false
        self.passwordTextField.isUserInteractionEnabled = false
        self.apiKeyTextFField.isUserInteractionEnabled = false
        
    }

    
    // MARK: - Delegate methods
    
    func showAlertController() {
        let alert = UIAlertController.init(title: "Not registered!", message: "To get access full functional please register!", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: { [weak self] action in
            guard let self = self else {return}
            self.navigationController!.popToRootViewController(animated: true)
            self.view.layer.sublayers?.removeLast()
        })
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: { [weak self] action in
            guard let self = self else {return}
            self.tabBarController!.selectedIndex = 0
            self.view.layer.sublayers?.removeLast()
        })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        let layer = CALayer.init()
        layer.frame = UIScreen.main.bounds
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = 0.8
        
        self.view.layer.addSublayer(layer)
        self.present(alert, animated: true, completion:nil)
        
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
