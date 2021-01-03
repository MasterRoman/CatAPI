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
    
     // MARK: Delegate methods
    
    func pushMainVC() {
        //
    }
    
    func showAPIWebPage() {
        //
    }
    
    
    
}
