//
//  UploadViewController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UploadViewDelegateProtocol {

    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    private var presenter : UploadPresenter!
    
    private var catsSource : Array<CatModel>?
    
    private var indicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = UploadPresenter.init()
       
        self.catsSource = Array.init()
        
        self.setUpCollectionView()
        
        self.presenter.setUploadViewDelegate(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.checkUserRegistration()
    }
    
    private func setUpCollectionView(){
        self.layout = UICollectionViewFlowLayout.init()
        self.layout.scrollDirection = .vertical
        self.layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 0, right: 10)
        self.layout.sectionHeadersPinToVisibleBounds = true
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: self.layout)
       
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.presenter!.registerCell(for: self.collectionView!)
        
        self.view.addSubview(self.collectionView!)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
  
    
    
    //MARK: Collection view dataSorce methods 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsSource!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! CatCell
        //configure with image
        
        return cell
    }
    
    //MARK: CollectionView Delegate methods
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
     
        let width = (self.collectionView.frame.size.width - 40 - 2 * 5) / 3.0

        return CGSize(width: width,height: width)
    }
    
    //MARK: FLow layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (UIDevice.current.orientation.isLandscape){
            return 10
        }
        return 30
    }
    
    //MARK: Delegate methods
    
    func showCats(array: Array<CatModel>) {
        
    }
    
    func addMoreImages(array: Array<CatModel>) {
            
    }
    
    func checkUserRegistration() {
        
    }
    
    func showAlertController() {
        
    }
    
    func showErrorAlert(error: Error?) {
        
    }
    
    func showAuthErrorAlert() {
        
    }
    
    func startIndicator() {
        self.indicator!.startAnimating()
    }
    
    func stopIndicator() {
        self.indicator!.stopAnimating()
    }
    
    
}
