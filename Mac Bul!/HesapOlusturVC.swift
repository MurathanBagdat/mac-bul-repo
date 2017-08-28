//
//  HesapOlusturVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class HesapOlusturVC: UIViewController {

    //Outlets
    @IBOutlet weak var kullancıAdıField: TextFieldWithInsets!
    @IBOutlet weak var emailField: TextFieldWithInsets!
    @IBOutlet weak var şifreField: TextFieldWithInsets!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
     
    }
    @IBAction func kaydetButtonPrsd(_ sender: UIButton) {
        
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let username  = kullancıAdıField.text , kullancıAdıField.text != "" else {return}
        guard let password = şifreField.text , şifreField.text != "" else {return}
        spinner.isHidden = false
        spinner.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        AuthService.instance.createUser(withEmail: email, andPassword: password, username: username) { (succes, error) in
            
            if succes{
                AuthService.instance.signInUser(withEmail: email, andPassword: password, completionHandler: { (succes, error) in
                    if succes{
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.performSegue(withIdentifier: "toSecimVC", sender: nil)
                    }else{
                        print("error2")
                    }
                })
            }else{
                print("error1")
            }
        }
    }
    @IBAction func zatenHesabımVarButtonPrsd(_ sender: UIButton) {
        performSegue(withIdentifier: "toHesabaGirVC", sender: nil)
    }


}
