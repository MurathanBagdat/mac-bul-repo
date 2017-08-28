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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sehrindeRakipBulMucadeleyeBaslaLabel.alpha = 0
        kendineTakımYadaRakipBulLabel.alpha = 0
        hadiBaslıyalımButton.alpha = 0
        
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2, animations: {
                self.sehrindeRakipBulMucadeleyeBaslaLabel.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.4, animations: {
                self.kendineTakımYadaRakipBulLabel.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.hadiBaslıyalımButton.alpha = 1
                }, completion: nil)
            })
            
        }
    }
    
    
    
    @IBAction func backButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func hadiBaslıylımButtonPrsd(_ sender: WhiteBorderButton) {
    }


}
