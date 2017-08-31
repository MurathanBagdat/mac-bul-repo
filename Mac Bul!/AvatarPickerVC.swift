//
//  AvatarPickerVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 30.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var images = [UIImage]()
    var seçilenLogo = String()
    var isFormEditing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        for i in 0...18{
            
            images.append(UIImage(named: "image\(i)")!)
        }
        
    }
    
    @IBAction func backButtonPrsd(_ sender: UIButton) {
      
            
            self.dismiss(animated: true, completion: nil)
    }
}



extension AvatarPickerVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarPickerCell else {return UICollectionViewCell()}
        
        let image = images[indexPath.row]
        
        cell.configureCell(avatarImage: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumn : CGFloat = 3
        
        if UIScreen.main.bounds.width > 320{
            numberOfColumn = 4
        }
        
        let padding : CGFloat = 40
        
        let spaceBetweenCell : CGFloat = 10
        
        let cellDimension = (UIScreen.main.bounds.width - padding - (spaceBetweenCell*numberOfColumn))/numberOfColumn
        
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isFormEditing{
            let selectedImageName = "image\(indexPath.item)"
            editingImageName = selectedImageName
            dismiss(animated: true, completion: nil)
            isFormEditing = false
        }else{
            let selectedImageName = "image\(indexPath.item)"
            takimLogosuIsmi = selectedImageName
            dismiss(animated: true, completion: nil)
        }
            
        
    }

    
}

