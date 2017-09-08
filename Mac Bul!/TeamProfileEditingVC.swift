//
//  TeamProfileEditingVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 30.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
var editingImageName : String?
class TeamProfileEditingVC: UIViewController {

    
    //Outlets
    @IBOutlet weak var teamLogoImageView: RoundedImage!
    @IBOutlet weak var takımIsmiTextFiedl: EditingTextField!
    @IBOutlet weak var SehirTextField: EditingTextField!
    @IBOutlet weak var baslangıcDatePicker: CustomDatePicker!
    @IBOutlet weak var bitisDatePicker: CustomDatePicker!
    @IBOutlet weak var başlangıçTarihiHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var bitişTarihiHeightConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var scroll: UIScrollView!{
        didSet{
            let tab = UITapGestureRecognizer(target: self, action: #selector(TeamProfileEditingVC.dismissKeyboard))
            scroll.addGestureRecognizer(tab)
        }
    }
    deinit {
        print("editingprofile killed")
    }
    
    var oldTeam : BasketballTeam?
    var takımLogosuRengi : String?
    var isBaslangıçPickerShown = false
    var isBitişPickerShown = false
    
    func initTeam(team :BasketballTeam){
        self.oldTeam = team
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTheBitişPicker()
        self.hideTheBaslangıcPicker()
        registerForKeyboardNotifications()
        bitisDatePicker.minimumDate = baslangıcDatePicker.date.addingTimeInterval(7200)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if editingImageName != nil {
            self.teamLogoImageView.image = UIImage(named: editingImageName!)
        }else{
            self.teamLogoImageView.image = UIImage(named: (self.oldTeam?.takımLogoIsmi)!)
        }
        
        self.takımLogosuRengi = self.oldTeam?.takımLogoRenk!
        self.teamLogoImageView.backgroundColor = DatabaseService.instance.returnUIColorFromString(component: (self.oldTeam?.takımLogoRenk!)!)
        self.takımIsmiTextFiedl.text = oldTeam?.takimIsmi!
        self.SehirTextField.text = oldTeam?.sehir
        
        let baslganıcDateInString = self.oldTeam?.baslangicTarih
        let bitişDateInString = self.oldTeam?.bitisTarihi
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "tr_TR")
        let baslangıcInDate = formatter.date(from: baslganıcDateInString!)
        let bitişInDate = formatter.date(from: bitişDateInString!)
        
        self.baslangıcDatePicker.date = baslangıcInDate!
        self.bitisDatePicker.date = bitişInDate!
        
        
    }
    
    @IBAction func cleanerForTeamName(_ sender: UIButton) {
        self.takımIsmiTextFiedl.becomeFirstResponder()
        self.takımIsmiTextFiedl.text = ""
        sender.isEnabled = false
        sender.isHidden = true
        print("called")
    }
    @IBAction func cleanerForSehirName(_ sender: UIButton) {
        self.SehirTextField.becomeFirstResponder()
        self.SehirTextField.text = ""
        sender.isEnabled = false
        sender.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func baslangıcDatePickerValueChanged(_ sender: CustomDatePicker) {
        bitisDatePicker.minimumDate = baslangıcDatePicker.date
        bitisDatePicker.date = baslangıcDatePicker.date.addingTimeInterval(3600)
    }
    @IBAction func başlangıçTarihiToogle(_ sender: UIButton) {
        
        if self.isBaslangıçPickerShown{
            hideTheBaslangıcPicker()
            self.isBaslangıçPickerShown = false
        }else{
            if isBitişPickerShown{
                hideTheBitişPicker()
                self.isBitişPickerShown = false
            }
            showTheBaslangıcPicker()
            self.isBaslangıçPickerShown = true
        }
        
    }
    @IBAction func bitişTarihiToogle(_ sender: UIButton) {
        
        if self.isBitişPickerShown{
            hideTheBitişPicker()
            self.isBitişPickerShown = false
        }else{
            if isBaslangıçPickerShown{
                hideTheBaslangıcPicker()
                self.isBaslangıçPickerShown = false
            }
            showTheBitişPicker()
            self.isBitişPickerShown = true
        }
        
    }
    
 
    @IBAction func kaydetButtonPrsd(_ sender: UIButton) {
        var logoName = String()
        
        if editingImageName != nil{
            logoName = editingImageName!
        }else{
            logoName = (self.oldTeam?.takımLogoIsmi)!
        }
        
        guard let yeniTakimIsmi = takımIsmiTextFiedl.text, takımIsmiTextFiedl.text != "" else {
            let alertController = UIAlertController(title: "Takım ismini doldurmayı unutma", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let yeniSehir = SehirTextField.text , SehirTextField.text != "" else {
            let alertController = UIAlertController(title: "Oynamak istediğin ve sana yakın olan semtleri gir", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
       
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "tr_TR")
        
        let bitisDateInString = formatter.string(from: bitisDatePicker.date)
        let baslangıçDateInString = formatter.string(from: baslangıcDatePicker.date)
        
        DatabaseService.instance.updatingBasketballTeamData(forTeamKey: (oldTeam?.takımKey)!, baslangıçTarihi: baslangıçDateInString, bitişTarihi: bitisDateInString, takımIsmi: yeniTakimIsmi, sehir: yeniSehir, logoIsmi: logoName, logoRengi: takımLogosuRengi!) { (succes) in
            if succes{
                self.performSegue(withIdentifier: "unwindToTeamsVC", sender: nil)
            }
        }

        
    }

    @IBAction func arkaPlanaRenkVerButtonPrsd(_ sender: UIButton) {
        
        
        let r  = CGFloat(arc4random_uniform(255)) / 255
        let g  = CGFloat(arc4random_uniform(255)) / 255
        let b  = CGFloat(arc4random_uniform(255)) / 255
        
        self.takımLogosuRengi = "[\(r), \(g), \(b), 1]"
        
        
        UIView.animate(withDuration: 0.2) {
            self.teamLogoImageView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        }

    }
 
    @IBAction func selectAnImage(_ sender: UIButton) {
        let destVC = storyboard?.instantiateViewController(withIdentifier: "AvatarPickerVC") as! AvatarPickerVC
        destVC.isFormEditing = true
        present(destVC, animated: true, completion: nil)
    }
    @IBAction func closeButtonpresd(_ sender: UIButton) {
        dismissDetail()
    }
    
    func showTheBaslangıcPicker(){
        self.baslangıcDatePicker.isHidden = false
        self.başlangıçTarihiHeightConstrain.constant = 296
    }
    func hideTheBaslangıcPicker(){
        self.baslangıcDatePicker.isHidden = true
        self.başlangıçTarihiHeightConstrain.constant = 75
    }
    func showTheBitişPicker(){
        self.bitişTarihiHeightConstraint.constant = 296
        self.bitisDatePicker.isHidden = false
    }
    func hideTheBitişPicker(){
        self.bitişTarihiHeightConstraint.constant = 75
        self.bitisDatePicker.isHidden = true
    }
}


//KeyboardHandling
extension TeamProfileEditingVC{
    
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
    
    func dismissKeyboard(){
        self.takımIsmiTextFiedl.resignFirstResponder()
        self.SehirTextField.resignFirstResponder()
    }
    
}








