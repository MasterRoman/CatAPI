//
//  MainTabBarController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var catViewController : CatViewController?
    private var uploadViewController : UploadViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
    }
    
    private func setUpView(){
        
        self.catViewController = CatViewController.init()
        let catTab : UITabBarItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "cat_unselected"), selectedImage: UIImage.init(named: "cat_selected"))
        self.catViewController?.tabBarItem = catTab
        let catNavigationController : UINavigationController = UINavigationController.init(rootViewController: self.catViewController!)
        
        self.uploadViewController = UploadViewController.init()
        let uploadTab : UITabBarItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "upload_unselected"), selectedImage: UIImage.init(named: "upload_selected"))
        self.uploadViewController?.tabBarItem = uploadTab
        let uploadNavigationController : UINavigationController = UINavigationController.init(rootViewController: self.uploadViewController!)
        
        
        self.viewControllers = [catNavigationController,uploadNavigationController]
        self.selectedIndex = 0
        
    }

}
