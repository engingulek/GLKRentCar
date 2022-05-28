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
class HomePageVC:UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var orderDetail: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var advertCarName: UILabel!
    @IBOutlet weak var advertCarModel: UILabel!
    @IBOutlet weak var advertCarPlate: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var gaOilLabel: UILabel!
    @IBOutlet weak var gearTypeLabel: UILabel!
    
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var logLabel: UILabel!
    
    var  distanceCarLocationFromMyLocation = [String:Double]()
    var latitude = Double()
    var longitude = Double()
    var lastLocation: CLLocation!
    var carLocation : CLLocation?
    var selectedCarLocation:CLLocation!
    @IBOutlet weak var advertCarImage: UIImageView!
    private var carRentAdvertVMList  = CarRentAdvertListViewModel()
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        getDataAdvertList()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
    manager.requestWhenInUseAuthorization()
       manager.startUpdatingLocation()
        
        
        
        
        
        
        
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
                    
                    self.getData()
                    
                    let advertCountA = self.carRentAdvertVMList.numberOfItemsInSection()
                    print("Advert Count \(advertCountA)")
                }
            case .failure(_):break
                }
            }
       }
    
}

//Show rental cars on the map
extension HomePageVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       lastLocation = locations[locations.count-1]
        myCoordinate(lastLocation)
        reachLoc()
    }
    
    
    
    // user reached car location
    func reachLoc() {
        print(lastLocation.coordinate.longitude)
        print(longitude)
        print(lastLocation.coordinate.latitude)
        print(latitude)
        if lastLocation.coordinate.longitude == longitude && lastLocation.coordinate.latitude == latitude {
            
        }
    }
    
    
    

  
    
    
    
    func myCoordinate(_ mylocation:CLLocation) {
        let location = CLLocationCoordinate2D(latitude: mylocation.coordinate.latitude, longitude: mylocation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        let areaMyLocation = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(areaMyLocation, animated: true)
        
        print("My Loc \(mylocation.coordinate.latitude) \(mylocation.coordinate.longitude)")
    }
    
    
  
    
    func calculatorDistance() {
        
        for advert in self.carRentAdvertVMList.carRentAdvertList {
             carLocation = CLLocation(latitude: Double(advert.carLocationLatitude)!, longitude: Double(advert.carLocationLongtude)!)
            /// CLLocationDistance to Double
            let distance = (carLocation!.distance(from: lastLocation)*1000)/1000
            
            distanceCarLocationFromMyLocation[advert.advertId] = distance
            
        }
    }
    
    func readUI(advert:CartRentAdvertViewModel) {
        self.advertCarName.text = advert.carInfo.carName
        self.advertCarName.text = advert.carInfo.carName
        self.advertCarModel.text = advert.carInfo.carModel
        self.advertCarPlate.text = advert.carInfo.carPlate
        self.gearTypeLabel.text = advert.carInfo.carGearType
        self.latitude = Double(advert.carLocationLatitude)!
        self.longitude = Double(advert.carLocationLongtude)!
        self.gaOilLabel.text = "%\(advert.carGasolineState)"
        let url = URL(string: "\(advert.carInfo.carImage)")
        self.advertCarImage.kf.setImage(with: url)
        
        
       
    }
    
        // read data nearest car advert
    func getData(){
       calculatorDistance()
       
       let sortResult = distanceCarLocationFromMyLocation.sorted(by: {$0.0 > $1.0})
          let nearestCar = sortResult[0]
       for advert in self.carRentAdvertVMList.carRentAdvertList {
           if nearestCar.key == advert.advertId {
               // read data to ui
               
               self.locLabel.text =  String(format: "%.3f", nearestCar.value/1000)+"km"
              
             
               readUI(advert: advert)
              
               
           }
           carCoordinates(carLocationLatitude: advert.carLocationLatitude,carLocationLongtude: advert.carLocationLongtude,carName:advert.carInfo.carName)
       }
    }
    
    
    
    func carCoordinates(carLocationLatitude:String,carLocationLongtude:String,carName:String) {
        
        let location = CLLocationCoordinate2D(latitude: Double(carLocationLatitude)!, longitude: Double(carLocationLongtude)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let areaMyLocation = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(areaMyLocation, animated: true)
        
        let pinCar = MKPointAnnotation()
        pinCar.coordinate = location
         pinCar.title = carName
         mapView.addAnnotation(pinCar)
    }

    // view navigation map
    @IBAction func rentCarAction(_ sender: Any) {
        let requestLocation = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
            if let placemark = placemarks {
                if placemark.count > 0 {
                    let newPlaceMark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlaceMark)
                    item.name =  "\(self.advertCarName.text!)-\(self.advertCarPlate.text!)"
                     
                    let launcOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
                    item.openInMaps(launchOptions: launcOptions)
                    }
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
}


extension HomePageVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let loc1 = CLLocation(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
        
        for advert in self.carRentAdvertVMList.carRentAdvertList {
            
            let loc2 = CLLocation(latitude: Double(advert.carLocationLatitude)!, longitude: Double(advert.carLocationLongtude)!)
            
            if loc1.coordinate.latitude == loc2.coordinate.latitude  {
               
                readUI(advert: advert)
                let carLocation = CLLocation(latitude: Double(advert.carLocationLatitude)!, longitude: Double(advert.carLocationLongtude)!)
                self.selectedCarLocation = carLocation
           
                
                let distance = (carLocation.distance(from: lastLocation)*1000)/1000
                 self.locLabel.text =  String(format: "%.3f", distance/1000)+"km"
            }
        }
        
        
    }
 
}


