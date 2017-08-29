//
//  BasketballMainVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class BasketballMainVC: UIViewController {

    //Outlets
    @IBOutlet weak var sehrindeRakipBulMucadeleyeBaslaLabel: UILabel!
    @IBOutlet weak var kendineTakımYadaRakipBulLabel: UILabel!
    @IBOutlet weak var hadiBaslıyalımButton: WhiteBorderButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var takımınHazırView: ViewWithWhiteBorder!
    @IBOutlet weak var eşleşmeArayanTakımlarView: ViewWithWhiteBorder!
    @IBOutlet weak var takımlarHazırAdameksikView: WhiteBorderButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sehrindeRakipBulMucadeleyeBaslaLabel.alpha = 0
        hadiBaslıyalımButton.alpha = 0
        takımınHazırView.transform = CGAffineTransform(translationX: 0, y: -300)
        eşleşmeArayanTakımlarView.transform = CGAffineTransform(translationX: 0, y: -410)
        takımlarHazırAdameksikView.transform = CGAffineTransform(translationX: 0, y: -550)
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       UIView.animate(withDuration: 0.3, animations: { 
        self.sehrindeRakipBulMucadeleyeBaslaLabel.alpha = 1
       }) { (true) in
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.takımınHazırView.transform = .identity
        }, completion: { (true) in
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.eşleşmeArayanTakımlarView.transform = .identity
            }, completion: { (true) in
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                    self.takımlarHazırAdameksikView.transform = .identity
                }, completion: { (true) in
                    UIView.animate(withDuration: 1, animations: {
                        self.hadiBaslıyalımButton.alpha = 1
                    }, completion: nil)
                })
            })
        })
        }
    }
    
    
    
    @IBAction func backButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func hadiBaslıylımButtonPrsd(_ sender: WhiteBorderButton) {
    }


}
