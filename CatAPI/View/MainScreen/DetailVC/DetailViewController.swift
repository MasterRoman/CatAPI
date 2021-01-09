//
//  DetailViewController.swift
//  CatAPI
//
//  Created by Admin on 09.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,DetailViewDelegateProtocol {
    var imageView: UIImageView?
    
    var url: String?
    
    var saveButton: UIButton?
    
    required init(with image: UIImage, url: String) {
        super.init(nibName: nil, bundle: nil)
        self.imageView = UIImageView.init(image: image)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSavedStatusAlert() {
        let alert = UIAlertController.init(title: "Save", message: "Saved!", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    


}
