//
//  LogInPage.swift
//  GLKRentCar
//
//  Created by engin gülek on 22.05.2022.
//

import Foundation
import UIKit


import FirebaseAuth

class LogInPage : UIViewController {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
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

// LogIn
extension LogInPage {
    @IBAction func loginButtonAction(_ sender: Any) {
        if (self.emailTextField.text == "" || self.passwordTextField.text == ""){
            self.alertMessage(message: "There is free space", title: "Error")
        }else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!){
                authResult,error in
                
                if let error = error {
                    self.alertMessage(message: error.localizedDescription, title: "Error")
                    
                }else{
                    self.performSegue(withIdentifier: "toHomePage", sender: nil)
                }
            }
        }
    }
    
    
    // Error alert message
    func alertMessage(message:String,title:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okey", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
}



