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
