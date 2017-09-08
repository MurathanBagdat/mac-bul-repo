//
//  HesabaGirVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class HesabaGirVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var emailField: DesingableTextFieldWithAnImage!
    @IBOutlet weak var passwordField: DesingableTextFieldWithAnImage!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }

    @IBAction func girişButtonPrsd(_ sender: UIButton) {
        
        guard let email = emailField.text , emailField.text != "" else {return}
        guard let password = passwordField.text , passwordField.text != "" else {return}
        spinner.isHidden = false
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        spinner.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        AuthService.instance.signInUser(withEmail: email, andPassword: password) { (succes, error) in
            if succes{
                sleep(1)
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                self.performSegue(withIdentifier: "tosSecimVC", sender: nil)
            }
        }
        
        
    }
    @IBAction func closeButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
