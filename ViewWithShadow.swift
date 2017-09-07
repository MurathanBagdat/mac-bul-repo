//
//  ViewWithShadow.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 7.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class ViewWithShadow: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.85
    }

}
