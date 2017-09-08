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
    
    @IBInspectable var shadowColor : UIColor = .black {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0 {
        didSet{

            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var borderColor : UIColor = .white{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    

    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    
    func setupView(){
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.cornerRadius = cornerRadius
    }
}
