//
//  CatCell.swift
//  CatAPI
//
//  Created by Admin on 07.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class CatCell: UICollectionViewCell {
    
    var catImageUrl : String!
    var catImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        self.catImageView = UIImageView.init(image: UIImage.init(named: "cat"))
        self.addSubview(self.catImageView)
        self.catImageView.contentMode = .scaleAspectFill
        self.catImageView.layer.cornerRadius = 20;
        self.catImageView.layer.masksToBounds = true;
        
        self.catImageView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            self.catImageView.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor),
            self.catImageView.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor),
            self.catImageView.trailingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.trailingAnchor),
            self.catImageView.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}
