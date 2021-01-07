//
//  CatViewDelegateProtocol.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import Foundation
import UIKit

protocol CatViewDelegateProtocol {
    
    
    var collectionView : UICollectionView! { get set}
    var layout : UICollectionViewFlowLayout! { get set }
    var numberOfItems : Int { get set };
    
    func showCats(array : Array<CatModel>)
    func addMoreImages(array : Array<CatModel>)
    func presentDetailViewController(controller : UIViewController?)
    func showAlertController(error : Error?)
    func startIndicator()
    
}
