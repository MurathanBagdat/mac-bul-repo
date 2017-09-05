//
//  ImageViewWithShadow.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 4.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class ImageViewWithShadow: UIImageView {

    override func awakeFromNib() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.85
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
        
        super.awakeFromNib()
    }

}
