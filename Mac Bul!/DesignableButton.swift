//
//  DesignableButton.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 8.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit



@IBDesignable
class DesignableButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor : UIColor = .clear {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0 {
        didSet{
            
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var borderColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0){
        didSet{
            layer.borderColor = borderColor.cgColor
            
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var shadowOpacity : Float = 0.75{
        didSet{
            layer.shadowOpacity = shadowOpacity
        }
    }
    
  
    
   
}
