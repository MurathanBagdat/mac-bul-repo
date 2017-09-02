//
//  RegistrationTextField.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 1.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class RegistrationTextField: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    private var editingBounds = CGRect(x: 0, y: -50, width: 1000, height: 50)
    
    override func awakeFromNib() {
        setupView()
        
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        if self.isFirstResponder{
            return UIEdgeInsetsInsetRect(editingBounds, padding)
        }else{
            return UIEdgeInsetsInsetRect(bounds, padding)
        }
        
    }
    
    
    func setupView(){
        let placeholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSForegroundColorAttributeName:#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.4974597393)])
        
        self.attributedPlaceholder = placeholder
    }


}
