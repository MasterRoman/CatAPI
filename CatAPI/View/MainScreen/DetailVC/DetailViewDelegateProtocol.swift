//
//  DetailViewDelegateProtocol.swift
//  CatAPI
//
//  Created by Admin on 09.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewDelegateProtocol {
    
    var imageView : UIImageView? { get set }
    var saveButton : UIButton? {get set}

    var catCell : CatCell? {get set}
    
    init(with cell : CatCell)
    func showSavedStatusAlert()
    
}
