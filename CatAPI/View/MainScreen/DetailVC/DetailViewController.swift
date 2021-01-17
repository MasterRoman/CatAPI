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
    var saveButton: UIButton?
    var catCell : CatCell?
    
    var presenter : MainPresenter?
    
    required init(with cell:CatCell) {
        super.init(nibName: nil, bundle: nil)
        self.catCell = cell
        self.imageView = UIImageView.init(image: cell.catImageView.image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ((self.imageView!.image!.isEqual(UIImage.init(named: "cat"))))
        {
            self.presenter!.downloadDetailImage(for: self.catCell!.catImageUrl)
        }
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
        self.presenter!.setDetailViewDelegate(view: self)
        self.setUpView()

    }
    
    private func setUpView(){
        self.view.addSubview(self.imageView!)
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
       
        self.imageView!.contentMode = .scaleAspectFit
        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.saveButton = UIButton.init(type: .custom)
        let saveImage : UIImage = UIImage.init(named: "save")!
        self.saveButton!.setImage(saveImage, for: .normal)
        self.saveButton?.addTarget(self, action: #selector(self.saveImageToGallery), for: .touchUpInside)
        
        self.saveButton!.tintColor = UIColor.white
        self.saveButton!.translatesAutoresizingMaskIntoConstraints = false
       
        self.imageView!.isUserInteractionEnabled = true
        self.imageView!.addSubview(self.saveButton!)
        
        NSLayoutConstraint.activate([
            self.imageView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.imageView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.imageView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.imageView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.saveButton!.heightAnchor.constraint(equalToConstant: 50),
            self.saveButton!.widthAnchor.constraint(equalToConstant: 50),
            self.saveButton!.trailingAnchor.constraint(equalTo: self.imageView!.trailingAnchor , constant: -10),
            self.saveButton!.bottomAnchor.constraint(equalTo: self.imageView!.bottomAnchor , constant: -10),
        ])
        
    }
    
    @objc private func saveImageToGallery(){
        self.presenter!.saveToGallery(image: self.imageView!.image!)
        self.presenter!.presentSaveAlert()
    }
    


}
