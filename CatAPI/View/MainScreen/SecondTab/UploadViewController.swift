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
        self.setUpActivityIndicator()
        
        self.presenter.setUploadViewDelegate(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.checkUserRegistration()
    }
    
    private func setUpActivityIndicator(){
        if #available(iOS 13, *){
            self.indicator = UIActivityIndicatorView.init(style: .large)
        }
        else
        {
            self.indicator = UIActivityIndicatorView.init(style: .whiteLarge)
        }
        self.collectionView.addSubview(self.indicator!)
        self.indicator!.color = UIColor.white
        self.indicator!.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        
        self.indicator!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.indicator!.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor),
            self.indicator!.centerYAnchor.constraint(equalTo: self.collectionView.centerYAnchor),
        ])
        
        self.indicator!.isUserInteractionEnabled = false
        self.indicator!.startAnimating()
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
        self.presenter.dowloadImage(for: cell, indexPath: indexPath)
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
        self.catsSource = array
        DispatchQueue.main.async {
            self.indicator!.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func addMoreImages(array: Array<CatModel>) {
            
    }
    
    func checkUserRegistration() {
        self.presenter!.downloadCats()
        self.startIndicator()
        
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
