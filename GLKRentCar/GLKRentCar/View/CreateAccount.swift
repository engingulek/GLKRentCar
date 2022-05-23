//
//  AccountPage.swift
//  GLKRentCar
//
//  Created by engin gülek on 22.05.2022.
//

import Foundation
import UIKit
import FirebaseAuth


class CreateAccount : UIViewController {
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var nameTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    // create account function
    @IBAction func createAccount(_ sender: Any) {
        
        if (self.emailTextField.text == "" || self.passwordTextField.text == "" || self.nameTextField.text == ""){
            self.alertMessage(alertTitle: "Error", alertMessage: "There is free empty")
            
        }else {
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { authResult, error in
                if error != nil {
                    
                }else {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "\(String(describing: self.nameTextField.text))"
                    self.performSegue(withIdentifier: "toHomePage", sender: nil)
                                     
                }
                
            }
            
        }
       
    }
    
    /// error alert message
    func alertMessage(alertTitle:String,alertMessage:String)
    {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Oket", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    
}


