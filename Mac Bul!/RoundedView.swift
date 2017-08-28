//
//  RoundedView.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        super.awakeFromNib()
    }

}
