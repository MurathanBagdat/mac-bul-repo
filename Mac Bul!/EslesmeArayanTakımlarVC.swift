//
//  EslesmeArayanTakımlarVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

let eslesmeArayanTakımCellIde = "eslesmeArayanTakımCell"

class EslesmeArayanTak_mlarVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var aramaTextField: SearchTextField!
    
    
    //Varibles
    
    var teamsArray = [BasketballTeam]()
    var isFirstTime = true
    var selectedTeam = BasketballTeam()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        DatabaseService.instance.REF_BASKETBALLTEAM.observe(.value, with: { (snapshot) in
            DatabaseService.instance.getBasketballTeamsFeed { (basketballTeamsArray) in
                self.teamsArray = basketballTeamsArray
                self.tableView.reloadData()
            }
        })
        
    }
    @IBAction func logoutButtonPrsd(_ sender: UIButton) {
        try? Auth.auth().signOut()
        let hesapOluştırVC = storyboard?.instantiateViewController(withIdentifier: "HesapOlusturVC") as! HesapOlusturVC
        present(hesapOluştırVC, animated: true, completion: nil)
    }
    @IBAction func editingChanged(_ sender: SearchTextField) {
        
        if aramaTextField.text != ""{
            if isFirstTime{
                self.teamsArray.removeAll()
                DatabaseService.instance.getBasketballTeam(forSearchQuery: aramaTextField.text!.lowercased(with: Locale(identifier: "tr_TR")), completion: { (returnedBasketballTeams, succes) in
                    if succes{
                        self.teamsArray = returnedBasketballTeams
                        self.tableView.reloadData()
                        self.isFirstTime = false
                    }
                })
            }else{
                DatabaseService.instance.getBasketballTeam(forSearchQuery: aramaTextField.text!.lowercased(with: Locale(identifier: "tr_TR")), completion: { (returnedBasketballTeams, succes) in
                    if succes{
                        self.teamsArray = returnedBasketballTeams
                        self.tableView.reloadData()
                    }
                })
            }
        }else{
            self.teamsArray.removeAll()
            DatabaseService.instance.getBasketballTeamsFeed(completion: { (returnedBasketballTeams) in
                
                    self.teamsArray = returnedBasketballTeams
                    self.tableView.reloadData()
            })
        }
        
  }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
}


extension EslesmeArayanTak_mlarVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: eslesmeArayanTakımCellIde, for: indexPath) as? EslesmeArayanTakimCell else {return UITableViewCell() }
        
        let basketballTeam = teamsArray[indexPath.row]
        cell.configureCell(basketballTeam: basketballTeam)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let team = teamsArray[indexPath.row]
        if editingStyle == .delete && team.kurucuUID == Auth.auth().currentUser?.uid{
            DatabaseService.instance.deleteBasketballTeam(forTeamKey: team.takımKey!, completion: { (succes) in
                if succes{
                    self.teamsArray.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            })
            
        } else{
            let alertController = UIAlertController(title: "Sadece Takım Kurucuları Takımlarını Silebilir!", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTeam = teamsArray[indexPath.row]
        let teamChatVC = storyboard?.instantiateViewController(withIdentifier: "TeamChatVC") as! TeamChatVC
        teamChatVC.initTeam(team: selectedTeam)
        teamChatVC.takımKurucuUID = selectedTeam.kurucuUID
        presentDetail(teamChatVC)
    }
}


