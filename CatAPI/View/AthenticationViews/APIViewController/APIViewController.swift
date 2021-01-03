//
//  APIViewController.swift
//  CatAPI
//
//  Created by Admin on 30.12.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

import UIKit

class APIViewController: UIViewController,APIDelegateProtocol {
   
    private var presenter : APIPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = APIPresenter.init()
        self.presenter.setAPIViewDelegate(view: self)
    }
    
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
    }
    @IBAction func confirmButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func getButtonDidPress(_ sender: UIButton) {
        self.presenter.showApiWebPages()
    }
    // MARK: Delegate methods
    
    func pushMainVC() {
        //
    }
    
    func showAPIWebPage() {
        let url : URL = URL(string : "https://thecatapi.com/signup")!
        UIApplication.shared.open(url, options:[:], completionHandler: nil)
    }
    
    
    
}
