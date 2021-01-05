//
//  UploadViewController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UploadViewDelegateProtocol {
    
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
    
}
