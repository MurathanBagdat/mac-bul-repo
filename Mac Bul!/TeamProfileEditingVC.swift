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
    
    @IBOutlet weak var scroll: UIScrollView!{
        didSet{
            let tab = UITapGestureRecognizer(target: self, action: #selector(TeamProfileEditingVC.dismissKeyboard))
            scroll.addGestureRecognizer(tab)
        }
    }
    
    var oldTeam : BasketballTeam?
    var takımLogosuRengi : String?
    
    
    func initTeam(team :BasketballTeam){
        self.oldTeam = team
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        

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
    }

    @IBAction func kaydetButtonPrsd(_ sender: UIButton) {
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








