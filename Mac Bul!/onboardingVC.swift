//
//  onboardingVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class onboardingVC: UIViewController {
    
    
    @IBOutlet weak var macbulaHosgeldinLabel: UILabel!
    @IBOutlet weak var kendineHalısahaEkibiMiArıyorsunView: ViewWithWhiteBorder!
    @IBOutlet weak var basketEkibineSonDakikaView: ViewWithWhiteBorder!
    @IBOutlet weak var DişineGöreRakipTakımView: ViewWithWhiteBorder!
    @IBOutlet weak var oZamanDoğruYerdesinLabel: UILabel!
    @IBOutlet weak var kaydolButton: WhiteBorderButton!
    @IBOutlet weak var bgImage: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        macbulaHosgeldinLabel.alpha = 0
        kendineHalısahaEkibiMiArıyorsunView.alpha =  0
        basketEkibineSonDakikaView.alpha = 0
        DişineGöreRakipTakımView.alpha = 0
        oZamanDoğruYerdesinLabel.alpha = 0
        kaydolButton.transform = CGAffineTransform(translationX: 0, y: 100)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.8, animations: {
            self.macbulaHosgeldinLabel.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 1.8, animations: {
                self.kendineHalısahaEkibiMiArıyorsunView.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 1.8, animations: {
                    self.basketEkibineSonDakikaView.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 1.5, animations: {
                        self.bgImage.alpha = 0.6
                        self.DişineGöreRakipTakımView.alpha = 1
                    }, completion: { (true) in
                        UIView.transition(with: self.bgImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            self.bgImage.image = #imageLiteral(resourceName: "kramponBG")
                        }, completion: { (true) in
                            UIView.animate(withDuration: 1.8, animations: {
                                self.oZamanDoğruYerdesinLabel.alpha = 1
                            }, completion: { (true) in
                                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
                                    self.kaydolButton.transform = .identity
                                }, completion: nil)
                            })
                        })
                    })
                })
            })
        }
    }
    
    
}
