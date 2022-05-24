//
//  CarRentAdvertDetails.swift
//  GLKRentCar
//
//  Created by engin gülek on 24.05.2022.
//

import Foundation
import UIKit
import MapKit

class CarRentAdvertListVC:UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var orderDetail: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
        
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailView.layer.cornerRadius = 45
        detailView.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        
        orderDetail.layer.cornerRadius = 20
        orderDetail.layer.borderWidth = 1
        orderDetail.layer.borderColor = UIColor.lightGray.cgColor
        orderDetail.layer.shadowColor = UIColor.lightGray.cgColor
        orderDetail.layer.shadowOpacity = 0.6
        orderDetail.layer.shadowOffset = .zero
        orderDetail.layer.shadowRadius = 10
      
        
    }
   
    
    
}
