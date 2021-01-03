//
//  RegistrationViewController.swift
//  CatAPI
//
//  Created by Admin on 28.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,RegistrationDelegateProtocol {
    
    private var viewBox : UIView!
    private var presenter : RegistrationPresenter!
    private var mainLabel : UILabel!
    private var secondaryLabel : UILabel!
    private var loginTextField : UITextField!
    private var passwordTextField : UITextField!
    private var cancelButton : UIButton!
    private var createButton : UIButton!
    private var positionConstantraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
        self.presenter =  RegistrationPresenter.init()
        self.presenter.setRegistationViewDelegate(view: self)
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeOnKeyBoardEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSubscribeOnKeyBoardEvent()
    }
    
    func setUpView(){
        let screen = UIScreen.main.bounds
        self.viewBox = UIView.init(frame: CGRect.zero)
        self.viewBox.backgroundColor = UIColor.systemGroupedBackground
        self.viewBox.isOpaque = true
        self.viewBox.layer.cornerRadius = 5.0
        self.viewBox.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.viewBox)
        self.positionConstantraint = self.viewBox.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant:-25)
        NSLayoutConstraint.activate([
            self.viewBox.widthAnchor.constraint(equalToConstant: screen.width - 60),
            self.viewBox.heightAnchor.constraint(equalToConstant: screen.height / 2.5),
            self.viewBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.positionConstantraint,
        ])
        

        self.mainLabel = UILabel.init(frame: CGRect.init(x: 50, y: 50, width: 200, height: 200))
        self.mainLabel.text = "Registration"
        var font = UIFont.boldSystemFont(ofSize: 30.0)
        self.mainLabel.font = font

        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false

        self.viewBox.addSubview(self.mainLabel)
        
        NSLayoutConstraint.activate([
            self.mainLabel.topAnchor.constraint(equalTo: self.viewBox.topAnchor,constant: 5.0),
            self.mainLabel.heightAnchor.constraint(equalToConstant: 45.0),
            self.mainLabel.centerXAnchor.constraint(equalTo: self.viewBox.centerXAnchor),
        ])

        self.secondaryLabel = UILabel.init()
        self.secondaryLabel.text = "Write your data"
        font = UIFont.systemFont(ofSize: 22.0)
        self.secondaryLabel.font = font

        self.secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewBox.addSubview(self.secondaryLabel)
        
        NSLayoutConstraint.activate([
            self.secondaryLabel.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor,constant: 8.0),
            self.secondaryLabel.heightAnchor.constraint(equalToConstant: 30.0),
            self.secondaryLabel.centerXAnchor.constraint(equalTo: self.viewBox.centerXAnchor),
        ])
        
        self.loginTextField = UITextField.init(frame: CGRect.zero)
        self.loginTextField.attributedPlaceholder = NSAttributedString(string: "login",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        self.loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.loginTextField.frame.height))
        self.loginTextField.leftViewMode = .always
        
        self.loginTextField.layer.cornerRadius = 5.0
        self.loginTextField.backgroundColor = UIColor.lightGray
        self.loginTextField.textColor = UIColor.white
        
        self.loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewBox.addSubview(self.loginTextField)
        
        NSLayoutConstraint.activate([
            self.loginTextField.topAnchor.constraint(equalTo: self.secondaryLabel.bottomAnchor,constant: 15.0),
            self.loginTextField.heightAnchor.constraint(equalToConstant: 30.0),
            self.loginTextField.leadingAnchor.constraint(equalTo: self.viewBox.leadingAnchor, constant: 10.0),
            self.loginTextField.trailingAnchor.constraint(equalTo: self.viewBox.trailingAnchor, constant: -10.0),
        ])
        

      
        self.passwordTextField = UITextField.init(frame: CGRect.zero)
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        self.passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.passwordTextField.frame.height))
        self.passwordTextField.leftViewMode = .always
        
        self.passwordTextField.layer.cornerRadius = 5.0
        self.passwordTextField.backgroundColor = UIColor.lightGray
        self.passwordTextField.textColor = UIColor.white
        
        
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewBox.addSubview(self.passwordTextField)
        
        NSLayoutConstraint.activate([
            self.passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor,constant: 10.0),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 30.0),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.viewBox.leadingAnchor, constant: 10.0),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.viewBox.trailingAnchor, constant: -10.0),
        ])
        
        
        self.cancelButton = UIButton.init(type: .system)
        self.cancelButton.backgroundColor = UIColor.systemGray5
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.viewBox.addSubview(self.cancelButton)
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.cancelButton.bottomAnchor.constraint(equalTo: self.viewBox.bottomAnchor,constant: -5.0),
            self.cancelButton.leadingAnchor.constraint(equalTo: self.viewBox.leadingAnchor,constant: 10.0),
            self.cancelButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor,constant: 20),
            self.cancelButton.widthAnchor.constraint(equalToConstant: (screen.width - 60) / 2.0 - 15)
            
        ])
        
        self.cancelButton.addTarget(self, action: #selector(self.cancelButtonDidPress), for: .touchUpInside)
        
        self.createButton = UIButton.init(type: .system)
        self.createButton.backgroundColor = UIColor.systemGray5
        self.createButton.setTitle("Create", for: .normal)
        self.viewBox.addSubview(self.createButton)
        
        self.createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.createButton.bottomAnchor.constraint(equalTo: self.viewBox.bottomAnchor,constant: -5.0),
            self.createButton.trailingAnchor.constraint(equalTo: self.viewBox.trailingAnchor,constant: -10.0),
            self.createButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor,constant: 20),
            self.createButton.widthAnchor.constraint(equalToConstant: (screen.width - 60) / 2.0 - 15)
            
        ])
        
         self.createButton.addTarget(self, action: #selector(self.createButtonDidPress), for: .touchUpInside)
    }
    
    @objc private func cancelButtonDidPress(){
        closeVC()
    }
    
    @objc private func createButtonDidPress(){
        presenter.checkUserEnteredLogin(userLogin: self.loginTextField.text!)
    }
    
    private func subscribeOnKeyBoardEvent(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func unSubscribeOnKeyBoardEvent(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyBoardWillShow(notification : Notification){
        let screen : CGRect = UIScreen.main.bounds
        let rect : CGRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        self.positionConstantraint.constant =  rect.size.height - (screen.height)/2.0
        
    }
    
    @objc private func keyBoardWillHide(notification : Notification){
         self.positionConstantraint.constant = -25
    }
    
    // MARK: Delegate methods
    
    func showAlertOfExisting() {
        let alertController : UIAlertController = UIAlertController.init(title: "", message: "Current login is already exist. Try another one.", preferredStyle: .alert)
        let alertAction : UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showApiEnteranceVC() {
        let apiVC : APIViewController =  APIViewController.init(nibName: "APIViewController", bundle: nil,login: self.loginTextField.text!,password: self.passwordTextField.text!)
     
        self.present(apiVC, animated: true, completion: nil)
        
        
    }

    func closeVC() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
