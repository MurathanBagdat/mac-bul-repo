//
//  AvatarPickerCell.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 30.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class AvatarPickerCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    func configureCell(avatarImage : UIImage){
        
        self.avatarImage.image = avatarImage
    }
}
