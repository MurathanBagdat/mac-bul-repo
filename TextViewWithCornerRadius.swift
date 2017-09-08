//
//  TextViewWithCornerRadius.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 7.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class TextViewWithCornerRadius: UITextView {

    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textContainerInset = UIEdgeInsets(top: 4, left: 10, bottom: 0, right: 10)

        super.awakeFromNib()
        
    }


}
