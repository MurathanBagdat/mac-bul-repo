//
//  WhiteBorderButton.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class WhiteBorderButton: UIButton {

    override func awakeFromNib() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        
        super.awakeFromNib()
    }
}
