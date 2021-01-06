//
//  CatViewController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class CatViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CatViewDelegateProtocol {
    
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var numberOfItems: Int = 0
    
    private var presenter : MainPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter.init()
        self.presenter?.setMainViewDelegate(view: self)
        self.setUpCollectionView()
    }
    
    
    //MARK: setUp View
    
    private func setUpCollectionView(){
        self.layout = UICollectionViewFlowLayout.init()
        self.layout.scrollDirection = .vertical
        self.layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 0, right: 10)
        self.layout.sectionHeadersPinToVisibleBounds = true
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: self.layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.presenter?.registerCell(for: self.collectionView!)
        
        self.view.addSubview(self.collectionView!)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
  
    
    // MARK: protocol methods

    
    func showCats(array: Array<CatModel>) {
        
    }
    
    func addMoreImages(array: Array<CatModel>) {
        
    }
    
    func presentDetailViewController(controller: UIViewController?) {
        
    }
    
    func showAlertController(error: String?) {
        
    }
    
    func startIndicator() {
        
    }
    
    //MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = UICollectionViewCell.init()
        return cell
    }
}
