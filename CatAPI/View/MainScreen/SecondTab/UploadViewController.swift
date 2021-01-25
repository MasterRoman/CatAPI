//
//  UploadViewController.swift
//  CatAPI
//
//  Created by Admin on 05.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UploadViewDelegateProtocol {

    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    private var presenter : UploadPresenter!
    
    private var catsSource : Array<CatModel>?
    
    private var indicator : UIActivityIndicatorView?
    
    private var deleteButton : UIBarButtonItem?
    private var uploadButton : UIBarButtonItem?
    
    private var selectedCell : CatCell? = nil
    private var isEnded : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = UploadPresenter.init()
       
        self.catsSource = Array.init()
        
        self.setUpCollectionView()
        self.setUpActivityIndicator()
        
        self.presenter.setUploadViewDelegate(view: self)
        
        self.setUpGestureRecognizer()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.checkUserRegistration()
       
    }
    
    private func setUpGestureRecognizer(){
        let pressGR = UILongPressGestureRecognizer.init(target: self, action: #selector(self.handleGesture(gesture:)))
        pressGR.minimumPressDuration = 0
        self.collectionView.addGestureRecognizer(pressGR)
    }
    
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
        self.indicator!.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        
        self.indicator!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.indicator!.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor),
            self.indicator!.centerYAnchor.constraint(equalTo: self.collectionView.centerYAnchor),
        ])
        
        self.indicator!.isUserInteractionEnabled = false
        self.indicator!.startAnimating()
    }
    
    private func setUpCollectionView(){
        
        self.uploadButton = UIBarButtonItem.init(image: UIImage.init(systemName: "plus")!, style: .plain, target: self, action: #selector(self.uploadButtonDidPress))
        self.deleteButton = UIBarButtonItem.init(image: UIImage.init(systemName: "trash")!, style: .plain, target: self, action: #selector(self.deleteButtonDidPress))
        
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
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
  
    
    //MARK: Button selector
    
    @objc private func handleGesture(gesture: UILongPressGestureRecognizer){
        switch gesture.state {
        
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            self.isEnded = false
            self.selectedCell = self.collectionView.cellForItem(at: selectedIndexPath) as? CatCell
            self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            self.isEnded = true
            collectionView.performBatchUpdates({
                self.collectionView.endInteractiveMovement()
            }, completion: { result in
                self.selectedCell = nil
            })
        default:
            self.isEnded = true
            self.collectionView.cancelInteractiveMovement()
        }
        
    }
    
    @objc private func deleteButtonDidPress(){
        guard let items = self.collectionView.indexPathsForSelectedItems else {
            return
        }
        let indexes = items.map{$0.item}.sorted().reversed()
        for index in indexes {
            let curCell = self.catsSource![index]
            self.catsSource!.remove(at: index)
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else {return}
                self.presenter!.deleteUplodedImage(with: curCell.imageId)
            }
        }
        DispatchQueue.main.async {
            self.collectionView.deleteItems(at: items)
            self.collectionView.reloadData()
        }
        self.presenter!.catsArray = self.catsSource
    }
    
    @objc private func uploadButtonDidPress(){
        self.startIndicator()
        DispatchQueue.main.async {
            let picker = UIImagePickerController.init()
            picker.delegate = self.presenter
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            self.present(picker, animated: true, completion: {
                self.stopIndicator()
            })
        }
    }
    
    //MARK: Collection view dataSorce methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsSource!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if ((self.isEnded) && (self.selectedCell != nil)){
            
            return self.selectedCell!
        } else {
            let cell : CatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! CatCell
            //configure with image
            self.presenter.dowloadImage(for: cell, indexPath: indexPath)
            if (self.navigationItem.rightBarButtonItems != nil){
                cell.isInEditingMode = true
            }
            
            return cell
        }
    }
    
    //MARK: CollectionView Delegate methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if (!editing){
            self.navigationItem.rightBarButtonItems = nil
        }
        else
        {
            self.navigationItem.setRightBarButtonItems([self.uploadButton!,self.deleteButton!], animated: true)
        }
        self.collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CatCell
            cell.isInEditingMode = editing
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
     
        let width = (self.collectionView.frame.size.width - 40 - 2 * 5) / 3.0

        return CGSize(width: width,height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = self.catsSource![sourceIndexPath.item]
        self.catsSource!.remove(at: sourceIndexPath.item)
        self.catsSource!.insert(movedItem, at: destinationIndexPath.item)
        
    }
    
    //MARK: FLow layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (UIDevice.current.orientation.isLandscape){
            return 10
        }
        return 30
    }
    
    //MARK: Delegate methods
    
    func showCats(array: Array<CatModel>) {
        self.catsSource = array
        DispatchQueue.main.async {
            self.indicator!.stopAnimating()
            self.collectionView.reloadData()
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func addMoreImages(array: Array<CatModel>) {
        
    }
    
    func checkUserRegistration() {
        if (self.catsSource?.count == 0){
            self.presenter!.downloadCats()
            // self.startIndicator()
        }
        
    }
    
    func showAlertController() {
        self.indicator!.stopAnimating()
        let alert = UIAlertController.init(title: "Not registered!", message: "To get access full functional please register!", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: { [weak self] action in
            guard let self = self else {return}
            self.tabBarController!.selectedIndex = 2
        })
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: { [weak self] action in
            guard let self = self else {return}
            self.tabBarController!.selectedIndex = 0
        })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(error: Error?) {
        
    }
    
    func showAuthErrorAlert() {
        
    }
    
    func startIndicator() {
        self.indicator!.startAnimating()
    }
    
    func stopIndicator() {
        self.indicator!.stopAnimating()
    }
    
    
}
