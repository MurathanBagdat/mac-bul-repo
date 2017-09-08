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
    @IBOutlet weak var kullancıAdıField: DesingableTextFieldWithAnImage!
    @IBOutlet weak var emailField: DesingableTextFieldWithAnImage!
    @IBOutlet weak var şifreField: DesingableTextFieldWithAnImage!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
        print("called")
     
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.transition(with: self.bgImage, duration: 5, options: [.transitionCrossDissolve], animations: {
            self.bgImage.image = #imageLiteral(resourceName: "basketFootballBG")
        }) { (succes) in
            UIView.transition(with: self.bgImage, duration: 7, options: [.transitionCrossDissolve], animations: {
                self.bgImage.image = #imageLiteral(resourceName: "footballBG")
            }, completion: { (succes) in
                if succes{
                    UIView.transition(with: self.bgImage, duration: 7, options: [.transitionCrossDissolve], animations: {
                        self.bgImage.image = #imageLiteral(resourceName: "tennisBG")
                    }, completion: { (succes) in
                        if succes{
                            UIView.transition(with: self.bgImage, duration: 7, options: [.transitionCrossDissolve], animations: {
                                self.bgImage.image = #imageLiteral(resourceName: "kramponBG")
                            }, completion: { (succes) in
                                if succes{
                                    UIView.transition(with: self.bgImage, duration: 7, options: [.transitionCrossDissolve], animations: {
                                        self.bgImage.image = #imageLiteral(resourceName: "tennisBG")
                                    }, completion: { (succes) in
                                        if succes{
                                            UIView.transition(with: self.bgImage, duration: 7, options: [.transitionCrossDissolve], animations: {
                                                self.bgImage.image = #imageLiteral(resourceName: "footballBG")
                                            }, completion: { (succes) in
                                                if succes{
                                                    UIView.transition(with: self.bgImage, duration: 7, options: [.transitionCrossDissolve], animations: {
                                                        self.bgImage.image = #imageLiteral(resourceName: "basketFootballBG")
                                                    }, completion: { (succes) in
                                                        if succes{
                                                            
                                                        }
                                                    })
                                                }
                                            })
                                        }
                                    })
                                }
                            })
                        }
                    })
                    
                }
            })
        }
        
        

    }
    @IBAction func kaydetButtonPrsd(_ sender: UIButton) {
        
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let username  = kullancıAdıField.text , kullancıAdıField.text != "" else {return}
        guard let password = şifreField.text , şifreField.text != "" else {return}
        spinner.isHidden = false
        spinner.startAnimating()
        kullancıAdıField.resignFirstResponder()
        emailField.resignFirstResponder()
        şifreField.resignFirstResponder()
        UIApplication.shared.beginIgnoringInteractionEvents()
        AuthService.instance.createUser(withEmail: email, andPassword: password, username: username) { (succes, error) in
            
            if succes{
                AuthService.instance.signInUser(withEmail: email, andPassword: password, completionHandler: { (succes, error) in
                    if succes{
                        sleep(2)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
