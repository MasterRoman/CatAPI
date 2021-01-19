//
//  UploadViewController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UploadViewDelegateProtocol {

    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
  //  private var presenter : UploadPresenter?
    
    private var catsSource : Array<CatModel>?
    
    private var indicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Collection view dataSorce methods 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = UICollectionViewCell.init()
        return cell
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
        
    }
    
    func stopIndicator() {
        
    }
    
    
}
