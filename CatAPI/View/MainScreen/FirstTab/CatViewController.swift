//
//  CatViewController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class CatViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CatViewDelegateProtocol {
    
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var numberOfItems: Int = 0
    
    private var presenter : MainPresenter?
    
    private var catsSource : Array<CatModel>?
    
    private var indicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MainPresenter.init()
        
        self.presenter!.setMainViewDelegate(view: self)
        
        self.catsSource = Array<CatModel>.init()
        
        self.setUpCollectionView()
        
        self.setUpChangeButton()
        
        self.presenter!.downloadCats()
        
        self.setUpActivityIndicator()
    }
    
    
    //MARK: setUp View
    
    private func setUpActivityIndicator(){
        if #available(iOS 13, *){
            self.indicator = UIActivityIndicatorView.init(style: .large)
        }
        else
        {
            self.indicator = UIActivityIndicatorView.init(style: .whiteLarge)
        }
        self.collectionView.addSubview(self.indicator!)
        self.indicator!.color = UIColor.white
        self.indicator!.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        
        self.indicator!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.indicator!.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor),
            self.indicator!.centerYAnchor.constraint(equalTo: self.collectionView.centerYAnchor),
        ])
        
        self.indicator!.isUserInteractionEnabled = false
        self.indicator!.startAnimating()
    }
    
    private func setUpChangeButton(){
        
        let changeButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon1"), style: .plain, target: self, action: #selector(self.changeLayout))
                                    
        self.navigationItem.rightBarButtonItem = changeButton;
        
    }
    
    private func setUpCollectionView(){
        self.layout = UICollectionViewFlowLayout.init()
        self.layout.scrollDirection = .vertical
        self.layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 0, right: 10)
        self.layout.sectionHeadersPinToVisibleBounds = true
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: self.layout)
       
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.presenter!.registerCell(for: self.collectionView!)
        
        self.view.addSubview(self.collectionView!)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
  
    
    @objc func changeLayout(){
        self.presenter!.changeLayout()
    }
    
    // MARK: protocol methods

    
    func showCats(array: Array<CatModel>) {
        self.catsSource = array
        DispatchQueue.main.async {
            self.indicator!.stopAnimating()
            self.collectionView.reloadData()
        }
        
    }
    
    func addMoreImages(array: Array<CatModel>) {
        
    }
    
    func presentDetailViewController(controller: UIViewController?) {
        
    }
    
    func showAlertController(error: Error?) {
        
    }
    
    func startIndicator() {
        
    }
    
    //MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsSource!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! CatCell
        self.presenter!.dowloadImage(for: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
        
        return footer
    }
    
    //MARK: CollectionView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height){
         //download more images
            self.presenter!.downloadCats()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter!.pushDetailVC(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.presenter!.cancelDownloadingImage(for: indexPath)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if (UIDevice.current.orientation.isLandscape){
            self.numberOfItems = 1
        }
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if (self.numberOfItems == 0) {
            if (self.collectionView.frame.size.height>self.collectionView.frame.size.width) {
                self.numberOfItems = 1;
            }
            else{
                self.numberOfItems = 3;
            }
        }
      
        let width = (self.collectionView.frame.size.width - CGFloat(40) - CGFloat(self.numberOfItems - 1) * 5) / CGFloat(self.numberOfItems)

        if (self.numberOfItems == 1) {
            let height : CGFloat = 300;
            
            return CGSize(width: width,height: height)
        }
       
        return CGSize(width: width,height: width)
    }
    
    //MARK: FLow layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (UIDevice.current.orientation.isLandscape){
            return 10
        }
        return 30
    }
}

