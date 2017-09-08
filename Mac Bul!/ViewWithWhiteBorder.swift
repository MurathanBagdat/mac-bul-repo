//
//  ViewWithWhiteBorder.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class ViewWithWhiteBorder: UIView {

    
    override func awakeFromNib() {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.76
        self.layer.shadowRadius = 5
        super.awakeFromNib()
    }
    
}
