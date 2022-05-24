//
//  HomePageViewController.swift
//  GLKRentCar
//
//  Created by engin gülek on 22.05.2022.
//

import Foundation
import UIKit
import Alamofire


class HomePageVC : UIViewController{
   
    
    
    @IBOutlet weak var advertRentCarCollectionView : UICollectionView!
    private var carRentAdvertVMList  = CarRentAdvertListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        advertRentCarCollectionView.delegate = self
        advertRentCarCollectionView.dataSource = self
      setupUI()
        getDataAdvertList()
    }
    
    func getDataAdvertList(){
        NetworkManager().fetch(url: "http://localhost:3000/carRentAdvertList"
                               , method:.get,requestModel: nil
                               , model: Carrentadvertresult.self)
        {response in
            
            
            switch (response){
            case .success(let model):
                let model = model as! Carrentadvertresult
                self.carRentAdvertVMList.carRentAdvertList = model.carAdvertList.map(CartRentAdvertViewModel.init)
                DispatchQueue.main.async {
                    self.advertRentCarCollectionView.reloadData()
                   let count = self.carRentAdvertVMList.numberOfItemsInSection()
                }
        
                
                
                break
                
            case .failure(_):break
                
            }
            
            
        }
       
     
    
}
    

    
    
}


extension HomePageVC :  UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carRentAdvertVMList.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = advertRentCarCollectionView.dequeueReusableCell(withReuseIdentifier: "advertRentCarCell", for: indexPath) as! AdvertRentCarCell
        let advert = self.carRentAdvertVMList.cellForItemAt(indexPath.row)
        
        
        
        
        cell.layer.cornerRadius = 10
        
        return cell
        
    }
    
    func setupUI(){
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWith = UIScreen.main.bounds.width
        let cellWidth = screenWith - 10
        design.itemSize = CGSize(width: cellWidth, height: 110)
        design.minimumLineSpacing = 25
        
        
        self.advertRentCarCollectionView.collectionViewLayout = design
    }
    
}

extension HomePageVC {
    // get all advert data from database

}
