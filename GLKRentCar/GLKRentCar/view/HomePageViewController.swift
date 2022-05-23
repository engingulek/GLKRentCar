//
//  HomePageViewController.swift
//  GLKRentCar
//
//  Created by engin gülek on 22.05.2022.
//

import Foundation
import UIKit


class HomePageViewController : UIViewController{
   
    
    @IBOutlet weak var advertRentCarCollectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        advertRentCarCollectionView.delegate = self
        advertRentCarCollectionView.dataSource = self
      setupUI()
    }
    

    
    
}


extension HomePageViewController :  UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = advertRentCarCollectionView.dequeueReusableCell(withReuseIdentifier: "advertRentCarCell", for: indexPath) as! AdvertRentCarCell
        
        
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
