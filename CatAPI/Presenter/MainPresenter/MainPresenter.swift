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
    
    override init() {
        self.parser = JSONParser.init()
        self.networkManeger = NetworkManager.init(withParser: self.parser!)
    }
    
    func setMainViewDelegate(view : CatViewDelegateProtocol){
        self.catDelegate = view
    }
    
    func registerCell(for collectionView:UICollectionView){
        
    }
    
}
