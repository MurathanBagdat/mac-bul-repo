//
//  RoundedViewWithSHADOW.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 3.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class RoundedViewWithSHADOW: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.black.cgColor
        self.clipsToBounds = false
        
        
        super.awakeFromNib()
    }
}
