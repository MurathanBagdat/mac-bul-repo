//
//  TeamChatCell.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 29.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class TeamChatCell: UITableViewCell {

    @IBOutlet weak var senderView : UIView!
    @IBOutlet weak var senderLabel : UILabel!
    @IBOutlet weak var senderTime: UILabel!
    @IBOutlet weak var alınanView : UIView!
    @IBOutlet weak var alınanLabel : UILabel!
    @IBOutlet weak var alınanKullanıcıAdı: UILabel!
    @IBOutlet weak var alınanTime: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func configureCell(message : BasketballTeamMessage){
        
        if Auth.auth().currentUser?.uid == message.senderID{
            self.senderView.isHidden = false
            self.alınanView.isHidden = true
            self.alınanKullanıcıAdı.text = ""
            self.alınanTime.text = ""
            self.alınanLabel.text = ""
            self.senderLabel.text = message.content
            self.senderTime.text = message.timestamp
            
        }else{
            self.alınanView.isHidden = false
            self.senderView.isHidden = true
            self.senderTime.text = ""
            self.senderLabel.text = ""
            self.alınanLabel.text = message.content
            self.alınanTime.text = message.timestamp
            self.alınanKullanıcıAdı.text = message.senderUsername
        }
        
        
    
    }
}
