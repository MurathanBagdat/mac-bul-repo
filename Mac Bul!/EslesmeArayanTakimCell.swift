//
//  EslesmeArayanTakimCell.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class EslesmeArayanTakimCell: UITableViewCell {
    
    
    
    //Outlets
    @IBOutlet weak var takımIsmiLabel: UILabel!
    @IBOutlet weak var enErkenOynamaTarihiLabel: UILabel!
    @IBOutlet weak var sehirLabel: UILabel!
    @IBOutlet weak var takımSayısıLabel: UILabel!
    @IBOutlet weak var sahaTercihiLabel: UILabel!
    @IBOutlet weak var bitisTarihiLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
    func configureCell(basketballTeam : BasketballTeam){
        
        self.takımIsmiLabel.text = "Takım ismi : \(basketballTeam.takimIsmi!)"
        self.enErkenOynamaTarihiLabel.text = "Başlangıç : \(basketballTeam.baslangicTarih!)"
        self.sehirLabel.text = "ŞEHİR : \(basketballTeam.sehir!)"
        self.takımSayısıLabel.text = "TAKIM SAYISI : \(basketballTeam.takimSayisi!)"
        self.sahaTercihiLabel.text = "Saha Tercihi : \(basketballTeam.lokasyonlar!)"
        self.bitisTarihiLabel.text = "Bitiş : \(basketballTeam.bitisTarihi!)"
    }

}
