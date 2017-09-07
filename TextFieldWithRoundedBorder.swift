//
//  TextFieldWithRoundedBorder.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 7.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class TextFieldWithRoundedBorder: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}
