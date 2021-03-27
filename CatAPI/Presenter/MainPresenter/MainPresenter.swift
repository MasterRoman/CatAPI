//
//  MainPresenter.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class MainPresenter: NSObject {
    
    weak private var catDelegate : CatViewDelegateProtocol?
    weak private var detailDelegate : DetailViewDelegateProtocol?
    private var networkManeger : NetworkManager?
    private var parser : JSONParser?
    private var catsArray : Array<CatModel>?
    
    private var isGridUI : Bool = false
    
    override init() {
        self.parser = JSONParser.init()
        self.networkManeger = NetworkManager.init(withParser: self.parser!)
        self.catsArray = Array<CatModel>.init()
    }
    
    func setMainViewDelegate(view : CatViewDelegateProtocol){
        self.catDelegate = view
    }
    
    func setDetailViewDelegate(view : DetailViewDelegateProtocol){
        self.detailDelegate = view
    }
    
    func registerCell(for collectionView:UICollectionView){
        collectionView.register(CatCell.classForCoder(), forCellWithReuseIdentifier: "CellId")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    //MARK: Dowloading
    
    func downloadCats(){
        
        let dispatchQueue =  DispatchQueue.global(qos: .utility)
        dispatchQueue.async {
            let url : String = "https://api.thecatapi.com/v1/images/search?limit=21"
            self.networkManeger!.loadCats(url: url) { [weak self] result in
                guard let self = self else {return}
                    switch result{
                    case .success(let array):
                        self.catsArray!.append(contentsOf: array)
                        self.catDelegate!.showCats(array: self.catsArray!)
                    case .failure(let error):
                        self.catDelegate!.showAlertController(error: error)
                }
            }
        }
    }
    
    func dowloadImage(for cell : CatCell,indexPath : IndexPath){
        cell.catImageUrl = self.catsArray![indexPath.row].url
        self.networkManeger?.getChachedImage(for: self.catsArray![indexPath.row].url, completion: { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    cell.catImageView.image = image
                case .failure(let error):
                    self.catDelegate!.showAlertController(error: error)
                }
            }
        })
        
    }
    
    func downloadDetailImage(for url: String){
        self.networkManeger!.getChachedImage(for: url, completion: { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    self.detailDelegate!.imageView!.image = image
                    self.detailDelegate!.catCell!.catImageView.image = image
                case .failure( _): break
                }
            }
            
        })
    }
    
    func cancelDownloadingImage(for indexPath:IndexPath){
        self.networkManeger?.cancelDownloadingForUrl(url:(self.catsArray?[indexPath.row].url)!)
    }
    
    
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
        DispatchQueue.main.async {  [weak self] in
            guard let self = self else {return}
            let catCell : CatCell = self.catDelegate!.collectionView.cellForItem(at: indexPath)! as! CatCell
            let detailVC = DetailViewController.init(with: catCell)
            detailVC.presenter = self
            self.catDelegate!.presentDetailViewController(controller:detailVC)
        }
    }
    
    func saveToGallery(image : UIImage){
        DispatchQueue.global(qos: .utility).async {
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
    }
    
    func presentSaveAlert(){
        self.detailDelegate!.showSavedStatusAlert()
    }
    
}
