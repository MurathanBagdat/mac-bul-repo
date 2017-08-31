//
//  TeamProfileEditingVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 30.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

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
    var imageName : String?
    
    func initTeam(team :BasketballTeam){
        self.oldTeam = team
    }
    
    func initImage(name : String){
        
        self.imageName = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if imageName != nil {
            self.teamLogoImageView.image = UIImage(named: imageName!)
        }else{
        self.teamLogoImageView.image = UIImage(named: (self.oldTeam?.takımLogoIsmi)!)
        }
        
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
    }
 
    @IBAction func selectAnImage(_ sender: UIButton) {
        
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








