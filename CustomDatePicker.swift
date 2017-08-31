//
//  CustomDatePicker.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 31.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class CustomDatePicker: UIDatePicker {

  
    override func awakeFromNib() {
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
        
        
        super.awakeFromNib()
    }
    
    
    
}
