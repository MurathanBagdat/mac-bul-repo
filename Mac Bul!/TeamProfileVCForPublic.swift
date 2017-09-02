//
//  TeamProfileVCForPublic.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 30.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class TeamProfileVCForPublic: UIViewController {

    //Outlets
    @IBOutlet weak var takımLogoImageView: RoundedImage!
    @IBOutlet weak var takımIsmiLabel: UILabel!
    @IBOutlet weak var takımKurucusuIsmiLabel: UILabel!
    @IBOutlet weak var oyuncuSayısıLabel: UILabel!
    @IBOutlet weak var takımKlasmanıLabel: UILabel!
    @IBOutlet weak var takımSehriLabel: UILabel!
    @IBOutlet weak var lokasyonTercihiLabel: UILabel!
    @IBOutlet weak var baslangıçTarihiLabel: UILabel!
    @IBOutlet weak var bitisTarihiLabel: UILabel!
    @IBOutlet weak var ekstraAçıklamalarLabel: UILabel!
    @IBOutlet weak var yaşOrtLabel: UILabel!
    @IBOutlet weak var ekstraAçıklamaHeadre: UILabel!

    
    var team : BasketballTeam?
    
    func initTeam(selectedTeam : BasketballTeam){
        self.team = selectedTeam
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let team = team {
            
            self.takımLogoImageView.image = UIImage(named: team.takımLogoIsmi)
            self.takımLogoImageView.backgroundColor = DatabaseService.instance.returnUIColorFromString(component: team.takımLogoRenk)
            self.takımIsmiLabel.text = team.takimIsmi
            self.takımKurucusuIsmiLabel.text = team.kurucuKullanıcıAdı!
            self.oyuncuSayısıLabel.text = team.takimSayisi!
            self.yaşOrtLabel.text = team.takımYasOrtalaması!
            self.takımKlasmanıLabel.text = team.takımSeviyesi!
            self.takımSehriLabel.text = team.sehir!
            self.baslangıçTarihiLabel.text = team.baslangicTarih
            self.bitisTarihiLabel.text = team.bitisTarihi
    }
    
    
    
    
    
   

    }
    @IBAction func closeButtonPrsd(_ sender: UIButton) {
        
        dismissDetail()
        
    }
    @IBAction func editingButtonPrsd(_ sender: UIButton) {
        if Auth.auth().currentUser?.uid == team?.kurucuUID {
            
            let destVC = storyboard?.instantiateViewController(withIdentifier: "TeamProfileEditingVC") as! TeamProfileEditingVC
            destVC.initTeam(team: team!)
            presentDetail(destVC)
            
        }else{
            let alertController = UIAlertController(title: "Sadece takımın kurucusu takım bilgilerini güncelliyebilir!", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
}
