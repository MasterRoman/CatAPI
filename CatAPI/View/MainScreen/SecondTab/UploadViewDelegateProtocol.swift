//
//  UploadDelegateProtocol.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import Foundation
import UIKit

protocol UploadViewDelegateProtocol {
    
    var collectionView : UICollectionView! { get set}
    
    func showCats(array : Array<CatModel>)
    func addMoreImages(array : Array<CatModel>)
    
    func checkUserRegistration()
    
    func showAlertController()
    func showErrorAlert(error : Error?)
    func showAuthErrorAlert()
   
    func startIndicator()
    func stopIndicator()
    
    

}
