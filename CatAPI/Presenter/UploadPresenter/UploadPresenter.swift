//
//  UploadPresenter.swift
//  CatAPI
//
//  Created by Admin on 19.01.2021.
//  Copyright © 2021 MasterCORP. All rights reserved.
//

import UIKit

class UploadPresenter: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var uploadDelegate : UploadViewDelegateProtocol?
    
    private var networkManeger : NetworkManager?
    
    private var userManeger : UserManager?
    
    private var parser : JSONParser?
    var catsArray : Array<CatModel>?
    
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
    
    
    //MARK: Downloading methods
    
    func downloadCats(){
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {return}
            let apiKey = self.getApi()
            let url : String = "https://api.thecatapi.com/v1/images?limit=100"
            //download cats by means of API
            self.networkManeger!.loadUplodedCats(for: url, apiKey: apiKey, completion: { [weak self] result in
                guard let self = self else {return}
                
                switch result{
                case .success(let array):
                    self.catsArray!.append(contentsOf: array)
                    self.uploadDelegate!.showCats(array: self.catsArray!)
                //MARK: TODO: Make failure branch
                
                case .failure(_): break
                    
                }
            })
        }
    }
    
    enum StringError : Error {
        
        case blockedImage
        
        var errorDiscription : String?{
            switch self {
            case .blockedImage:
                return "blockedImage"
            default:
                return "notFound"
            }
            
        }
        
    }
    
    func uploadImages(image : UIImage,url : String,completion : @escaping (Result<String,StringError>) -> ()){
        //upload images to server
        let queue = DispatchQueue.global(qos: .background)
        queue.async { [weak self] in
            guard let self = self else {return}
            let apiKey = self.getApi()
            self.networkManeger!.uploadImage(for: apiKey, fileName: url, image: image, completion: { result in
                
                switch result{
                case .success(let dict):
                    guard let id : String = dict["id"] as? String else {
                        completion(.failure(.blockedImage))
                        return
                    }
                    completion(.success(id))
                    
                //MARK: TODO:  make failure branch
                
                case .failure(_): break
                //show ALERT
                }
                
            })
        }
    }
    
    func dowloadImage(for cell : CatCell,indexPath : IndexPath){
        if (self.catsArray![indexPath.row].url != "blockedImage"){
            cell.catImageUrl = self.catsArray![indexPath.row].url
            self.networkManeger?.getChachedImage(for: self.catsArray![indexPath.row].url, completion: {  [weak self] result  in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case .success(let image):
                        cell.catImageView.image = image
                    //MARK: TODO: Make failure branch
                    case .failure(_): break
                    // self.catDelegate!.showAlertController(error: error)
                    }
                }
            })
        } else {
            cell.catImageView.image = UIImage.init(named: "blockedImage")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
                self.catsArray!.remove(at: indexPath.row)
                self.uploadDelegate!.showCats(array: self.catsArray!)
            })
        }
        
    }
    
    private func getApi()->String{
        return self.userManeger!.checkUserAPI()!
    }
    
    
    
    //MARK: interaction with delegate methods
    
    func checkUserRegistration(){
        let userIsRegistered : Bool = userManeger!.checkUserStatus()
        if (userIsRegistered){
            self.uploadDelegate!.checkUserRegistration()
        }
        else
        {
            self.uploadDelegate!.showAlertController()
        }
    }
    
    //MARK: Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {return}
            let chosenImage : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            let fileNameUrl = info[UIImagePickerController.InfoKey.imageURL]
            let fileName  : String = String.init(format: "%@", fileNameUrl as! CVarArg)
            let cat  = CatModel.init(with: fileName)
            self.catsArray!.append(cat)
            self.uploadImages(image: chosenImage, url: fileName, completion: { result in
                switch result{
                case .success(let id):
                    cat.imageId = id
                //MARK: TODO: Make failure branch
                case .failure(let error):
                    cat.url = error.errorDiscription!
                    self.uploadDelegate!.showCats(array: self.catsArray!)
                }
            })
            
            self.uploadDelegate!.showCats(array: self.catsArray!)
            DispatchQueue.main.async {
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func deleteUplodedImage(with imageId:String){
        let apiKey = self.userManeger!.checkUserAPI()
        self.networkManeger!.deleteUplodedImageFromServer(for: apiKey!, imageId: imageId, completion: { result in
            
        })
    }
    
    
}
