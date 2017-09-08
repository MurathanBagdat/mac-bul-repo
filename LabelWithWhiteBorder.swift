//
//  LabelWithWhiteBorder.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 7.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class LabelWithWhiteBorder: UILabel {

    override func awakeFromNib() {
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        
        super.awakeFromNib()
    }
    
    
}
