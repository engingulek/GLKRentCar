//
//  TimerRentCarVC.swift
//  GLKRentCar
//
//  Created by engin gülek on 29.05.2022.
//

import Foundation
import UIKit

class TimerRentVC : UIViewController{
    
    @IBOutlet weak var timerLabel: UILabel!
    var rentCar : CarRent!
    var timer:Timer = Timer()
    var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
    }
    
    
    // timer start
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    
    // conver timer to time
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
        
        func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    
    
    @IBAction func rentFinish(_ sender: Any) {
        count = count + 0
        let time = secondsToHoursMinutesSeconds(seconds: count)
        // default test minute
        ///let totalMinute = 20
        var amount = 0
        let totalMinute = (time.0*60) + time.1
        if totalMinute == 0 {
            amount = rentCar.advertMinuteCost
        }else{
             amount = totalMinute * rentCar.advertMinuteCost
        }
    
        alertMessage(title: "Finish Rent", message: "Amount \(amount)")
       
    }
    
    // create alert
    func alertMessage(title:String,message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okey", style: .default) { alert in
            self.performSegue(withIdentifier: "toFinish", sender: nil)
        }
        alertController.addAction(alertAction)
        // to HomePage
        self.present(alertController, animated: true)
    }
    
    
    
  
    
}
