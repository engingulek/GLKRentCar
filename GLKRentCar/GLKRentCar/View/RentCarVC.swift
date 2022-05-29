//
//  RentCar.swift
//  GLKRentCar
//
//  Created by engin gülek on 28.05.2022.
//

import Foundation
import UIKit
import Firebase
import Alamofire
class RentCarVC: UIViewController {
    var selectedaAdvert:CartRentAdvertViewModel!
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    
    @IBOutlet weak var carPassword: UITextField!
    @IBOutlet weak var carPlate: UILabel!
    @IBOutlet weak var carModel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        carName.text = selectedaAdvert.carInfo.carName
        carModel.text = selectedaAdvert.carInfo.carModel
        carPlate.text = selectedaAdvert.carInfo.carPlate
        carPrice.text = "₺\(selectedaAdvert.carRentMinuteCost)/dk"
        let url = URL(string: "\(selectedaAdvert.carInfo.carImage)")
        self.carImage.kf.setImage(with: url)
        
        
    }
    
    
    // the car rent and the data of advertisement  write to database
    @IBAction func rentCarAction(_ sender: Any) {
        if carPassword.text == selectedaAdvert.advertPassword {
            // rent car
          
            print("Button kontrol")
            let userId = Auth.auth().currentUser!.uid
            let now = Date()

               let formatter = DateFormatter()

               formatter.timeZone = TimeZone.current

               formatter.dateFormat = "yyyy-MM-dd HH:mm"

               let startTime = formatter.string(from: now)
            let advert = self.selectedaAdvert
            let newCarRentInfo = Carinfo(carName: advert!.carInfo.carName, carImage: advert!.carInfo.carImage, carModel: advert!.carInfo.carModel, carPlate: advert!.carInfo.carPlate, carGearType: advert!.carInfo.carGearType)
            let newCarRent = CarRent(userId: userId, startTime: startTime, advert: newCarRentInfo, advertMinuteCost: advert!.carRentMinuteCost)
        
            
            NetworkManager().fetch(url: "http://localhost:3000/carRent", method: .post, requestModel: newCarRent, model: CarRent.self) { response in
                
            }
            
            self.performSegue(withIdentifier: "toRentTimer", sender: newCarRent)
    }
    
}
    
    // go to timerViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRentTimer" {
            if let advert = sender as? CarRent {
                let toGoVC = segue.destination as! TimerRentVC
                toGoVC.rentCar = advert
            }
        }
        
    }
}
