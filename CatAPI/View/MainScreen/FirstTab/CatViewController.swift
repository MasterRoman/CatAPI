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
    
    
   
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = UICollectionViewCell.init()
        return cell
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
    
}
