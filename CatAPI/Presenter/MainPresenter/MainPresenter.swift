//
//  MainPresenter.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class MainPresenter: NSObject {
    
    private var catDelegate : CatViewDelegateProtocol?
    private var networkManeger : NetworkManager?
    private var parser : JSONParser?
    
    private var isGridUI : Bool = false
    
    override init() {
        self.parser = JSONParser.init()
        self.networkManeger = NetworkManager.init(withParser: self.parser!)
    }
    
    func setMainViewDelegate(view : CatViewDelegateProtocol){
        self.catDelegate = view
    }
    
    func registerCell(for collectionView:UICollectionView){
        collectionView.register(CatCell.classForCoder(), forCellWithReuseIdentifier: "CellId")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    //MARK: Dowloading
    
    //MARK: Presentation
    
    func changeLayout(){
        if (self.catDelegate!.numberOfItems == 1) {
            self.catDelegate!.numberOfItems = 3
            self.isGridUI = true
        } else {
            self.isGridUI = false
            self.catDelegate!.numberOfItems = 1
        }
        self.catDelegate!.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func pushDetailVC(indexPath : IndexPath){
        let catCell = self.catDelegate!.collectionView.cellForItem(at: indexPath)
        
       // self.catDelegate!.presentDetailViewController(controller: )
    }
    
    func saveToGallery(image : UIImage){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
}
