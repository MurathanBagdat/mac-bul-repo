//
//  RoundedImage.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 30.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height/2
        
        super.awakeFromNib()
    }
}
