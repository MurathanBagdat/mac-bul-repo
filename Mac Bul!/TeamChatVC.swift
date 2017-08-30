//
//  TeamChatVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 29.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class TeamChatVC: UIViewController {

    //Outlets
    @IBOutlet weak var teamNameView: UIView!{
        didSet{
            let downSwipeGestureRec = UISwipeGestureRecognizer(target: self, action: #selector(TeamChatVC.downGesture))
            downSwipeGestureRec.direction = .down
            teamNameView.addGestureRecognizer(downSwipeGestureRec)
        }
    }

    @IBOutlet weak var messageTextField: TextFieldWithInsets!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var canlıSohbetView: UIView!{
        didSet{
            let upSwipeGestureRec = UISwipeGestureRecognizer(target: self, action: #selector(TeamChatVC.upGesture))
            upSwipeGestureRec.direction = .up
            canlıSohbetView.addGestureRecognizer(upSwipeGestureRec)
        }
    }
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var takimIsmiLabel: UILabel!
    @IBOutlet weak var takimLogoImage: RoundedImage!
    
    //Variables
    var team : BasketballTeam?
    var messages : [BasketballTeamMessage] = [BasketballTeamMessage(content: "Henüz hiç mesaj yok!", messageID: "", senderID: "", timestamp: "", teamKey: "", senderUsername : "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        
        guard let takımKey = team?.takımKey else {
            dismiss(animated: true, completion: nil)
            return}
        
        
        
        DatabaseService.instance.REF_BASKETBALLTEAM.child(takımKey).child("messages").observe(.value, with: { (messagesSnapshot) in
            
            DatabaseService.instance.getTeamMessages(forTeamKey: takımKey, completion: { (returnedBasketballMessages, succes) in
                if succes{
                    
                    if returnedBasketballMessages.count == 0 {
                        return
                    }
                    self.messages = returnedBasketballMessages
                    self.tableView.reloadData()
                    self.scrolDownTheTableView()
                }
            })
        })

        
        //keyboardStuff#######
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //keyboardStuff#######
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let team  =  team else {
         dismiss(animated: true, completion: nil)
            return
        }
        guard let takımIsmi = team.takimIsmi else {dismiss(animated: true, completion:  nil)
            return}
        
        let takımKey = team.takımKey
        self.takimLogoImage.image = UIImage(named: team.takımLogoIsmi)
        self.takimLogoImage.backgroundColor = DatabaseService.instance.returnUIColorFromString(component: team.takımLogoRenk)
        self.takimIsmiLabel.text = takımIsmi
        
        
        //TAKIM MESAJLARINI ÇEK##########
        DatabaseService.instance.REF_BASKETBALLTEAM.child(takımKey!).child("messages").observe(.value, with: { (messagesSnapshot) in
            
            DatabaseService.instance.getTeamMessages(forTeamKey: takımKey!, completion: { (returnedBasketballMessages, succes) in
                if succes{
                    
                    if returnedBasketballMessages.count == 0 {
                        return
                    }
                    self.messages = returnedBasketballMessages
                    self.tableView.reloadData()
                    self.scrolDownTheTableView()
                }
            })
        })
        //TAKIM MESAJLARINI ÇEK##########
    }
    
    
    func initTeam(team : BasketballTeam){
        self.team = team
    }
    
    func upGesture(){
            UIView.animate(withDuration: 0.4, animations: {
                self.canlıSohbetView.isHidden = true
            
            }, completion: nil)
        
    }
    func downGesture(){
        UIView.animate(withDuration: 0.4, animations: {
            self.canlıSohbetView.isHidden = false
        })
    }
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButtonPrsd(_ sender: Any) {
        
        
        guard let messageContent = messageTextField.text , messageTextField.text != "" else {return}
        guard let teamkey = team?.takımKey else {return}
        sendButton.isEnabled = false
        self.messageTextField.text = ""
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .short
        dateformatter.locale = Locale(identifier: "tr_TR")
        let dateInString = dateformatter.string(from: date)
        
        DatabaseService.instance.createTeamMessage(teamkey: teamkey, content: messageContent, timestamp: dateInString, senderID: (Auth.auth().currentUser?.uid)!) { (succes) in
            if succes{
                self.sendButton.isEnabled = true
                self.scrolDownTheTableView()
            }
        }
    }
    
    func scrolDownTheTableView(){
        if messages.count > 0{
            
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .none, animated: false)
        }
    }
    
}

extension TeamChatVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

     return messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamChatCell", for: indexPath) as? TeamChatCell else { return UITableViewCell() }
        
        let message = messages[indexPath.row]
        
        cell.configureCell(message: message)
        
        return cell
        
    }
}

//KeyboardStuff

extension TeamChatVC {
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification:notification)
    }
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification:notification)
    }
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        bottomConstraint.constant = (view.bounds).maxY - (convertedKeyboardEndFrame).minY
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
            self.scrolDownTheTableView()
        }, completion: nil)
    }

}


