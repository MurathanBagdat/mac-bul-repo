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
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        super.awakeFromNib()
    }
    
}
