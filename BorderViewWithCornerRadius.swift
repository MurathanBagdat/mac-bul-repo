//
//  BorderViewWithCornerRadius.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 29.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class BorderViewWithCornerRadius: UIView {

   

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        
        super.awakeFromNib()
    }
    
}
