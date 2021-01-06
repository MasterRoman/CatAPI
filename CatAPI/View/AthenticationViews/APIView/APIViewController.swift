//
//  APIViewController.swift
//  CatAPI
//
//  Created by Admin on 30.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class APIViewController: UIViewController,APIDelegateProtocol {
   
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var textField: UITextField!
    private var presenter : APIPresenter!
    private var login : String!
    private var password : String!
    
    private var completion : ((Bool) -> Void)?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,login : String!,password : String!,completion : @escaping ((Bool) -> Void)) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.login = login
        self.password = password
        self.completion = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmButton.isEnabled = false
        
        self.presenter = APIPresenter.init()
        self.presenter.setAPIViewDelegate(view: self)
    }
    
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        if (!(sender.text!.isEmpty)){
            self.confirmButton.isEnabled = true
        }
        else
        {
            self.confirmButton.isEnabled = false
        }
        
    }
    @IBAction func confirmButtonDidPress(_ sender: UIButton) {
        self.presenter.registerUserAndPushMainVC(login: self.login!, password: self.password!, apiKey: self.textField.text!,isActive: true)
    }
    @IBAction func getButtonDidPress(_ sender: UIButton) {
        self.presenter.showApiWebPages()
    }
    // MARK: Delegate methods
    
    func pushMainVC() {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            if (self?.completion != nil){
                self?.completion!(true)
            }
        }
    }
    
    func showAPIWebPage() {
        DispatchQueue.main.async {
            let url : URL = URL(string : "https://thecatapi.com/signup")!
            UIApplication.shared.open(url, options:[:], completionHandler: nil)
        }
    }
    
    
    
}
