//
//  UploadPresenter.swift
//  CatAPI
//
//  Created by Admin on 19.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class UploadPresenter: NSObject {
    
    private var uploadDelegate : UploadViewDelegateProtocol?
    
    private var networkManeger : NetworkManager?
    
    private var userManeger : UserManager?
    
    private var parser : JSONParser?
    private var catsArray : Array<CatModel>?
    
    override init() {
        self.parser = JSONParser.init()
        self.networkManeger = NetworkManager.init(withParser: self.parser!)
        self.userManeger = UserManager.init()
        self.catsArray = Array<CatModel>.init()
    }
    
    func setUploadViewDelegate(view : UploadViewDelegateProtocol){
        self.uploadDelegate = view
    }
    
    func registerCell(for collectionView:UICollectionView){
        collectionView.register(CatCell.classForCoder(), forCellWithReuseIdentifier: "CellId")
//        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    
    
    
}
