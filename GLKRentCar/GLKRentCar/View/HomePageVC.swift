//
//  CarRentAdvertDetails.swift
//  GLKRentCar
//
//  Created by engin gülek on 24.05.2022.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Kingfisher
class HomePageVC:UIViewController, UIGestureRecognizerDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var orderDetail: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var advertCarName: UILabel!
    @IBOutlet weak var advertCarModel: UILabel!
    @IBOutlet weak var advertCarPlate: UILabel!
    var  distanceCarLocationFromMyLocation = [String:Double]()
    var lastLocation: CLLocation!
    @IBOutlet weak var advertCarImage: UIImageView!
    private var carRentAdvertVMList  = CarRentAdvertListViewModel()
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataAdvertList()
        
       // navigationCarLocationFromMyLocation()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
    manager.requestWhenInUseAuthorization()
       manager.startUpdatingLocation()
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       lastLocation = locations[locations.count-1]
        myCoordinate(lastLocation)
    }
    
    
    func myCoordinate(_ mylocation:CLLocation) {
        let location = CLLocationCoordinate2D(latitude: mylocation.coordinate.latitude, longitude: mylocation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let areaMyLocation = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(areaMyLocation, animated: true)
       
        print("My Loc \(mylocation.coordinate.latitude) \(mylocation.coordinate.longitude)")
    }
    
    
  
    
    func calculatorDistance() {
        for advert in self.carRentAdvertVMList.carRentAdvertList {
            let carLocation = CLLocation(latitude: Double(advert.carLocationLatitude)!, longitude: Double(advert.carLocationLongtude)!)
            /// CLLocationDistance to Double
            let distance = (carLocation.distance(from: lastLocation)*1000)/1000
            
            distanceCarLocationFromMyLocation[advert.advertId] = distance
            
        }
    }
    
    
        // read data nearest car advert
   func readDataToUI(){
       calculatorDistance()
       let sortResult = distanceCarLocationFromMyLocation.sorted(by: {$0.0 < $1.0})
          let nearestCar = sortResult[0]
       for advert in self.carRentAdvertVMList.carRentAdvertList {
           if nearestCar.key == advert.advertId {
               // read data to ui
               self.advertCarName.text = advert.carInfo.carName
               self.advertCarName.text = advert.carInfo.carName
               self.advertCarModel.text = advert.carInfo.carModel
               self.advertCarPlate.text = advert.carInfo.carPlate
               
               let url = URL(string: "\(advert.carInfo.carImage)")
               self.advertCarImage.kf.setImage(with: url)
               
           }
           carCoordinates(carLocationLatitude: advert.carLocationLatitude,carLocationLongtude: advert.carLocationLongtude,carName:advert.carInfo.carName)
       }
    }
    
    func carCoordinates(carLocationLatitude:String,carLocationLongtude:String,carName:String) {
        
        let location = CLLocationCoordinate2D(latitude: Double(carLocationLatitude)!, longitude: Double(carLocationLongtude)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let areaMyLocation = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(areaMyLocation, animated: true)
        
        let pinCar = MKPointAnnotation()
         pinCar.coordinate = location
         pinCar.title = carName
         mapView.addAnnotation(pinCar)
        
       
         
        
    }
    
    
    
    
    
    
    // car locaition
   /* func navigationCarLocationFromMyLocation() {
        
        let locationCar = CLLocationCoordinate2D(latitude: Double(advert.carLocationLatitude)!, longitude: Double(advert.carLocationLongtude)! )
        print("Car Loc \(advert.carLocationLatitude) \(advert.carLocationLongtude)")
        let spanCar = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let areaCar = MKCoordinateRegion(center: locationCar, span: spanCar)
        self.mapView.setRegion(areaCar, animated: true)
        
        // car location pin
       let pinCar = MKPointAnnotation()
        pinCar.coordinate = locationCar
        pinCar.title = "Car Location"
        mapView.addAnnotation(pinCar)
        
        
        
        
      
        
        
    }*/
    
    
    
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
                    self.mapView.reloadInputViews()
                    
                    self.readDataToUI()
                    
                    let advertCountA = self.carRentAdvertVMList.numberOfItemsInSection()
                    print("Advert Count \(advertCountA)")
                }
            case .failure(_):break
                }
            }
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


