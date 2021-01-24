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
    var checkmarkLabel : UILabel!
    
    var isInEditingMode: Bool = false {
        didSet {
            checkmarkLabel.isHidden = !isInEditingMode
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkmarkLabel.text = isSelected ? "✓" : ""
            }
        }
    }

    
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
        
        self.checkmarkLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        self.checkmarkLabel.font = UIFont.systemFont(ofSize:35.0, weight: .bold)
        self.checkmarkLabel.textColor = UIColor.red
        self.checkmarkLabel.numberOfLines = 0
        self.checkmarkLabel.contentMode = .scaleToFill
    
        
        
        self.catImageView.addSubview(self.checkmarkLabel)
        
        
        self.checkmarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.checkmarkLabel.bottomAnchor.constraint(equalTo:self.catImageView.bottomAnchor,constant: -10),
            self.checkmarkLabel.trailingAnchor.constraint(equalTo:self.catImageView.trailingAnchor,constant: -10),
            self.checkmarkLabel.heightAnchor.constraint(equalToConstant: 30.0),
            self.checkmarkLabel.widthAnchor.constraint(equalToConstant: 30.0),
        ])
        
        
    }
}
