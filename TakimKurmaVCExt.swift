//
//  TakimKurmaVCExt.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 5.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

extension Tak_mKurmaVC {
    func ikinciSayfayıGizle(){
        macSeviyesiSecView.isHidden = true
        yasOrtalamasıSec.isHidden = true
        ikinciButton.isHidden = true
        ikinciButton.isEnabled = false
    }
    func üçüncüSayfayıGizle(){
        self.üçüncüButton.isHidden = true
        self.üçüncüButton.isEnabled = false
        
        sehirYazmaView.isHidden = true
        mapView.isHidden = true
        pinLabel.isHidden = true
    }
    func dördüncüSayfayıGizle(){
        bitisView.isHidden = true
        baslangıçDatePciker.isHidden = true
        baslangıçHeightConstraing.constant = 75
        baslangıcView.isHidden = true
        zamanLabel.isHidden = true
        logoStackView.isHidden = true
        avatarButton.isHidden = true
        doneButton.isHidden = true
        
        bitişHeightConstraint.constant = 75
        bitişDatePicker.isHidden = true
        baslangıçDatePciker.date = Date()
        baslangıçDatePciker.minimumDate = Date()
        
        self.collecitionView.alpha = 0
    }
    func birinciSayfayıGizle(){
        takimIsmiTextField.isHidden = true
        takimSayısıTextField.isHidden = true
        ilkButton.isHidden = true
        ilkButton.isEnabled = false
    }
    func ikinciSayfayıGöster(){
        ikinciButton.isHidden = false
        ikinciButton.isEnabled = true
        macSeviyesiSecView.isHidden = false
        yasOrtalamasıSec.isHidden = false
    }
    func üçüncüSayfayıGöster(){
        self.üçüncüButton.isHidden = false
        self.üçüncüButton.isEnabled = true
        
        self.mapView.isHidden = false
        self.sehirYazmaView.isHidden = false
        self.pinLabel.isHidden = false
    }
    func dördüncüSayfayıGöster(){
        self.doneButton.isHidden = false
        self.zamanLabel.isHidden = false
        baslangıcView.isHidden = false
        bitisView.isHidden = false
        avatarButton.isHidden = false
        logoStackView.isHidden = false
    }
    func bitişDatePickerSakla(){
        self.bitişHeightConstraint.constant = 75
        self.bitişDatePicker.isHidden = true
        self.isBitisPickerShown = false
    }
    func başlangıçDatePickerGöster(){
        self.baslangıçHeightConstraing.constant = 220
        self.baslangıçDatePciker.isHidden = false
        self.isBaslangıcPickerShown = true
    }
    func başlangıçDatePickerSakla(){
        self.baslangıçHeightConstraing.constant = 75
        self.baslangıçDatePciker.isHidden = true
        self.isBaslangıcPickerShown = false
    }
    func bitişDatePickerGöster(){
        self.bitişHeightConstraint.constant = 220
        self.bitişDatePicker.isHidden = false
        self.isBitisPickerShown = true
    }
    //Animations
    func shakeTheTakımIsmiTextField(){
        UIView.animate(withDuration: 0.15, animations: {
            self.takimIsmiTextField.transform = CGAffineTransform(translationX: 10, y: 0)
        }, completion: { (succes) in
            if succes{
                UIView.animate(withDuration: 0.15, animations: {
                    self.takimIsmiTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                }, completion: { (succes) in
                    if succes{
                        UIView.animate(withDuration: 0.15, animations: {
                            self.takimIsmiTextField.transform = CGAffineTransform(translationX: 10 , y: 0)
                        }, completion: { (succes) in
                            if succes{
                                UIView.animate(withDuration: 0.1, animations: {
                                    self.takimIsmiTextField.transform = .identity
                                }, completion: nil)
                            }
                        })
                    }
                })
            }
        })
    }
    func shakeTheTakımSayısıTextField(){
        UIView.animate(withDuration: 0.15, animations: {
            self.takimSayısıTextField.transform = CGAffineTransform(translationX: 10, y: 0)
        }, completion: { (succes) in
            if succes{
                UIView.animate(withDuration: 0.15, animations: {
                    self.takimSayısıTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                }, completion: { (succes) in
                    if succes{
                        UIView.animate(withDuration: 0.15, animations: {
                            self.takimSayısıTextField.transform = CGAffineTransform(translationX: 10 , y: 0)
                        }, completion: { (succes) in
                            if succes{
                                UIView.animate(withDuration: 0.1, animations: {
                                    self.takimSayısıTextField.transform = .identity
                                }, completion: nil)
                            }
                        })
                    }
                })
            }
        })
    }
    func shakeTheMapView(){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.mapView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: { (succes) in
            if succes{
                UIView.animate(withDuration: 0.2, animations: {
                    self.mapView.transform = .identity
                }, completion: { (succes) in
                    if succes{
                        
                    }
                })
            }
        })
        
    }
    func shakeTheSehirView(){
        UIView.animate(withDuration: 0.15, animations: {
            self.sehirYazmaView.transform = CGAffineTransform(translationX: 10, y: 0)
        }, completion: { (succes) in
            if succes{
                UIView.animate(withDuration: 0.15, animations: {
                    self.sehirYazmaView.transform = CGAffineTransform(translationX: -10, y: 0)
                }, completion: { (succes) in
                    if succes{
                        UIView.animate(withDuration: 0.15, animations: {
                            self.sehirYazmaView.transform = CGAffineTransform(translationX: 10 , y: 0)
                        }, completion: { (succes) in
                            if succes{
                                UIView.animate(withDuration: 0.1, animations: {
                                    self.sehirYazmaView.transform = .identity
                                }, completion: nil)
                            }
                        })
                    }
                })
            }
        })
    }

    //KEYBOARDSTUF!!
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification:notification)
    }
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification:notification)
    }
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        ilkButtonBttomConstraint.constant = (view.bounds).maxY - (convertedKeyboardEndFrame).minY
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
 
    
}
