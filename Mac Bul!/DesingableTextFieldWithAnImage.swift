//
//  DesingableTextFieldWithAnImage.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 8.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit


@IBDesignable
class DesingableTextFieldWithAnImage: UITextField {

    
    
    @IBInspectable var leftImage : UIImage? {
        didSet{
            updateView()
        }
    }
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftpadding : CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var imageColor : UIColor = .white{
        didSet{
            
            updateView()
            
        }
    }
    
    
    
    func updateView(){
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftpadding , y: 0, width: 25, height: 25))

            imageView.contentMode = .scaleAspectFill
            imageView.image = image
            imageView.tintColor = imageColor
            
            var width = leftpadding + 25
            
            if borderStyle == .none || borderStyle == .line {
                
                width = width + 10 //rightPadding
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 25))
            
            view.addSubview(imageView)
            
            leftView = view
            
        }else{
            leftViewMode = .never

        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName : tintColor])
    }
    
    
    
    
}
