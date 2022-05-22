//
//  LogInPage.swift
//  GLKRentCar
//
//  Created by engin gülek on 22.05.2022.
//

import Foundation
import UIKit

class LogInPage : UIViewController {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var googleButton : UIButton!
    @IBOutlet weak var creatAccountToLabeL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        uıSetup()
        
        self.creatAccountToLabeL.isUserInteractionEnabled = true
        
        let tap =  UITapGestureRecognizer(target: self, action: #selector(toCreatePage(_:)))
        
        self.creatAccountToLabeL.addGestureRecognizer(tap)
    }
    
    
    
    @objc func toCreatePage(_ sender:Any){
      
        performSegue(withIdentifier: "toCreateAccountPage", sender: nil)
     
    }
    
    
    func uıSetup() {
        // emailTextField
        self.emailTextField.layer.borderWidth = 1
        self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.emailTextField.layer.cornerRadius = 10
        
        
        // passwordTextField
        self.passwordTextField.layer.borderWidth = 1
        self.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.passwordTextField.layer.cornerRadius = 10
        self.passwordTextField.isSecureTextEntry = true
        
        
        
        
        
        
        
        
        
       
        
    }
}



