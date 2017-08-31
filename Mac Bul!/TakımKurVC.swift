//
//  TakımKurVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

var takimLogosuIsmi = "image7"
class Tak_mKurVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerForEndDate: UIDatePicker!
    @IBOutlet weak var slider: CustomSlider!
    @IBOutlet weak var takimIsmiTextField: UITextField!
    @IBOutlet weak var takiminKacKisiTextField: UITextField!
    @IBOutlet weak var sehirTextField: UITextField!
    @IBOutlet weak var sahaLokasyonuTextFiled: UITextField!
    @IBOutlet weak var aciklamaTextView: UITextView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var avatarImageView: RoundedImage!
    @IBOutlet weak var yasSlider: UISlider!

   
    //Variables
    
    var takimLogosuRengi = "[0.87, 0.87, 0.87, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aciklamaTextView.delegate = self
        registerForKeyboardNotifications()
        datePicker.setDate(Date(), animated: false)
        datePicker.minimumDate = Date()
        datePickerForEndDate.minimumDate = Date().addingTimeInterval(7200)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.avatarImageView.image = UIImage(named: takimLogosuIsmi)
    }
    

    @IBAction func DatepickerDate(_ sender: UIDatePicker) {
        datePickerForEndDate.setDate(datePicker.date.addingTimeInterval(7200), animated: true)
        datePickerForEndDate.minimumDate = datePicker.date.addingTimeInterval(7200)

    }
    
    @IBAction func yasSliderChanged(_ sender: UISlider) {
        yasSlider.value = roundf(yasSlider.value)
    }
    
    @IBAction func sliderChanged(_ sender: CustomSlider) {
        slider.value = roundf(slider.value)
    }
    
    @IBAction func avatarPickerButtonPrsd(_ sender: UIButton) {
        let avatarPickerVC = storyboard?.instantiateViewController(withIdentifier: "AvatarPickerVC") as! AvatarPickerVC
        present(avatarPickerVC, animated: true, completion: nil)
    }
    
    
    @IBAction func arkaPlanRenkButtonPrsd(_ sender: Any) {
    
        let r  = CGFloat(arc4random_uniform(255)) / 255
        let g  = CGFloat(arc4random_uniform(255)) / 255
        let b  = CGFloat(arc4random_uniform(255)) / 255
        
        self.takimLogosuRengi = "[\(r), \(g), \(b), 1]"
        
        
        UIView.animate(withDuration: 0.2) {
            self.avatarImageView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }
    
    
    
    @IBAction func doneButtonPrsd(_ sender: Any) {
  
        guard let takımSayısı = takiminKacKisiTextField.text, takiminKacKisiTextField.text != "" else {
            
            let alertController = UIAlertController(title: "Takım kaç kişi bunu bilmemiz lazım..", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let takımIsmi = takimIsmiTextField.text, takimIsmiTextField.text != "" else {
            let alertController = UIAlertController(title: "Takımına bir isim ver maksat namın yürüsün!", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let sehir = sehirTextField.text , sehirTextField.text != "" else {
            let alertController = UIAlertController(title: "Şehir yada ilçe belirt ki çevrendeki rakip takımler seni bulabilsin", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        var seviye : String {
            switch slider.value{
            case 1:
                return "Eğlencesine"
            case 2 :
                return "Orta"
            case 3 :
                return "Uzman"
            default:
                return "Orta"
            }
        }
        
        var yaş : String{
            switch yasSlider.value{
            case 1 :
                return "-18"
            case 2 :
                return "18-25"
            case 3 :
                return "25-35"
            case 4:
                return "35+"
            default:
                return "18-25"
            }
        }
        guard let sahaLokasyonu = sahaLokasyonuTextFiled.text, sahaLokasyonuTextFiled.text != "" else {
            let alertController = UIAlertController(title: "Oynamak istediğin sahaları belirtmen faydalı olabilir", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        return
        }
        
        let bitisTarihiInDate = datePickerForEndDate.date
        let baslangicTarihiInDate = datePicker.date
        let date = baslangicTarihiInDate
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        let baslangıcDateInString = formatter.string(from: date)
        let bitisDateInString = formatter.string(from: bitisTarihiInDate)
        
        var esktraAciklamalar = aciklamaTextView.text ?? ""
        if aciklamaTextView.text == "Oynamaya hazır olduğun tarih ve saat aralıkları vs.."{
            
            esktraAciklamalar = ""
        
        }
        DatabaseService.instance.getUsername(byUID: (Auth.auth().currentUser?.uid)!) { (username, succes) in
            if succes{
             
                let basketballTakımı = BasketballTeam(kurucuUID: Auth.auth().currentUser?.uid, takimIsmi: takımIsmi, takimSayisi: takımSayısı, sehir: sehir, baslangicTarih: baslangıcDateInString, bitisTarihi: bitisDateInString, aciklama: esktraAciklamalar, kurucuKullanıcıAdı: username, takımSeviyesi: seviye, lokasyonlar: sahaLokasyonu, takımKey: nil, takımYasOrtalaması: yaş, takımLogoIsmi: takimLogosuIsmi, takımLogoRenk: self.takimLogosuRengi)
                
                DatabaseService.instance.createBasketballTeam(withBasketballTeam: basketballTakımı) { (succes) in
                    if succes{
                        
                    }
                }
            }
        }
    }
    
}

extension Tak_mKurVC{
    //keyboardHandling
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWasShown(_:)),
                                               name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillBeHidden(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue =
            info[UIKeyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0,
                                             keyboardSize.height, 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
        
    }
    
    func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension Tak_mKurVC : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.aciklamaTextView.text = ""
    }
}












