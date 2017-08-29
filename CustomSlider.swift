//
//  CustomSlider.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    override func awakeFromNib() {
        
        self.setThumbImage(#imageLiteral(resourceName: "boldBasketball-1") , for: .normal)
        self.setThumbImage(#imageLiteral(resourceName: "boldBasketball-1"), for: .highlighted)
        super.awakeFromNib()
    }
    
    
}
