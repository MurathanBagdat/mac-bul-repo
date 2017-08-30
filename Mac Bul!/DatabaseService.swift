//
//  DatabaseService.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DatabaseService {
    
    static let instance = DatabaseService()
    
    private let _REF_USERS = DB_BASE.child("USERS")
    private let _REF_BASKETBALL = DB_BASE.child("BasketballTeams")
    private let _REF_FOOTBALL = DB_BASE.child("FootballTeams")
    
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    var REF_BASKETBALLTEAM : DatabaseReference{
        return _REF_BASKETBALL
    }

    
    func createUserInDB(withUID uid : String, userData : Dictionary<String, Any> , completion : (_ succes: Bool)->()){
        
        REF_USERS.child(uid).updateChildValues(userData)
        completion(true)
        
    }
    func getUsername(byUID uid : String, completion : @escaping (_ username: String , _ succes : Bool)->()){
   
        REF_USERS.observeSingleEvent(of: .value, with: { (userSnapshot) in
           
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
    
            for user in userSnapshot {
                
                if user.key == Auth.auth().currentUser?.uid {
             
                    let username = user.childSnapshot(forPath: "username").value as! String
                    completion(username, true)
                }
            }
        })
    }
    
    func createBasketballTeam(withBasketballTeam basketballTeam : BasketballTeam , completion : @escaping (_ succes: Bool)->()) {
        
        REF_BASKETBALLTEAM.childByAutoId().updateChildValues(["Takımİsmi" : basketballTeam.takimIsmi , "TakımKurucuUID" : basketballTeam.kurucuUID , "TakımSeviyesi" : basketballTeam.takımSeviyesi, "TakımSayısı" : basketballTeam.takimSayisi , "Sehir" : basketballTeam.sehir, "Lokasyonlar" : basketballTeam.lokasyonlar, "KurucuKullanıcıAdı" : basketballTeam.kurucuKullanıcıAdı, "BaslangıçTarihi" : basketballTeam.baslangicTarih, "BitişTarihi" : basketballTeam.bitisTarihi, "EkstraAçıklamalar" : basketballTeam.aciklama, "yasOrt" : basketballTeam.takımYasOrtalaması , "logoIsmi" : basketballTeam.takımLogoIsmi, "logoRengi" : basketballTeam.takımLogoRenk ])
        
        completion(true)
    }
    
    func getBasketballTeamsFeed(completion : @escaping (_ basketballTeams : [BasketballTeam])->()){
        var basketballTeamArray = [BasketballTeam]()
        
        REF_BASKETBALLTEAM.observeSingleEvent(of: .value, with: { (basketballTeamsSnapshot) in
            
            guard let basketballTeamsSnapshot = basketballTeamsSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for returnedBasketballTeam in basketballTeamsSnapshot {
                
                
                let kurucuUID = returnedBasketballTeam.childSnapshot(forPath: "TakımKurucuUID").value as! String
                let takimIsmi = returnedBasketballTeam.childSnapshot(forPath: "Takımİsmi").value as! String
                let takimSayisi = returnedBasketballTeam.childSnapshot(forPath: "TakımSayısı").value as! String
                let sehir = returnedBasketballTeam.childSnapshot(forPath: "Sehir").value as! String
                let baslangicTarih = returnedBasketballTeam.childSnapshot(forPath: "BaslangıçTarihi").value as! String
                let bitisTarihi = returnedBasketballTeam.childSnapshot(forPath: "BitişTarihi").value as! String
                let aciklama = returnedBasketballTeam.childSnapshot(forPath: "EkstraAçıklamalar").value as! String
                let KurucuKullanıcıAdı = returnedBasketballTeam.childSnapshot(forPath: "KurucuKullanıcıAdı").value as! String
                let TakımSeviyesi = returnedBasketballTeam.childSnapshot(forPath: "TakımSeviyesi").value as! String
                let Lokasyonlar = returnedBasketballTeam.childSnapshot(forPath: "Lokasyonlar").value as! String
                let takımKey = returnedBasketballTeam.key
                let yasOrt = returnedBasketballTeam.childSnapshot(forPath: "yasOrt").value as! String
                let logoIsmi = returnedBasketballTeam.childSnapshot(forPath: "logoIsmi").value as! String
                let logoRenk = returnedBasketballTeam.childSnapshot(forPath: "logoRengi").value as! String
                
                    let basketballTeam = BasketballTeam(kurucuUID: kurucuUID, takimIsmi: takimIsmi, takimSayisi: takimSayisi, sehir: sehir, baslangicTarih: baslangicTarih, bitisTarihi: bitisTarihi, aciklama: aciklama, kurucuKullanıcıAdı: KurucuKullanıcıAdı, takımSeviyesi: TakımSeviyesi, lokasyonlar: Lokasyonlar, takımKey: takımKey, takımYasOrtalaması: yasOrt, takımLogoIsmi: logoIsmi, takımLogoRenk: logoRenk)
              
                basketballTeamArray.append(basketballTeam)
            }
            
            completion(basketballTeamArray)
        })
    }
    
    func deleteBasketballTeam(forTeamKey teamKey : String , completion : @escaping (_ succes : Bool)->()){
        
        REF_BASKETBALLTEAM.child(teamKey).removeValue()
        completion(true)
    }
    
    func getBasketballTeam(forSearchQuery query : String , completion: @escaping (_ basketballTeams : [BasketballTeam] , _ succes : (Bool))->()) {
        var basketballTeamArray = [BasketballTeam]()
        REF_BASKETBALLTEAM.observe(.value, with: { (basketballTeamsSnapshot) in
            guard let basketballTeamsSnapshot =  basketballTeamsSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for returnedBasketballTeam in basketballTeamsSnapshot{
               
                let sehir = returnedBasketballTeam.childSnapshot(forPath: "Sehir").value as! String
                let lowerSehir = sehir.lowercased(with: Locale(identifier: "tr_TR"))
                if lowerSehir.contains(query){
                    
                    let kurucuUID = returnedBasketballTeam.childSnapshot(forPath: "TakımKurucuUID").value as! String
                    let takimIsmi = returnedBasketballTeam.childSnapshot(forPath: "Takımİsmi").value as! String
                    let takimSayisi = returnedBasketballTeam.childSnapshot(forPath: "TakımSayısı").value as! String
                    let sehir = returnedBasketballTeam.childSnapshot(forPath: "Sehir").value as! String
                    let baslangicTarih = returnedBasketballTeam.childSnapshot(forPath: "BaslangıçTarihi").value as! String
                    let bitisTarihi = returnedBasketballTeam.childSnapshot(forPath: "BitişTarihi").value as! String
                    let aciklama = returnedBasketballTeam.childSnapshot(forPath: "EkstraAçıklamalar").value as! String
                    let KurucuKullanıcıAdı = returnedBasketballTeam.childSnapshot(forPath: "KurucuKullanıcıAdı").value as! String
                    let TakımSeviyesi = returnedBasketballTeam.childSnapshot(forPath: "TakımSeviyesi").value as! String
                    let Lokasyonlar = returnedBasketballTeam.childSnapshot(forPath: "Lokasyonlar").value as! String
                    let takımKey = returnedBasketballTeam.key
                    let yasOrt = returnedBasketballTeam.childSnapshot(forPath: "yasOrt").value as! String
                    let logoIsmi = returnedBasketballTeam.childSnapshot(forPath: "logoIsmi").value as! String
                    let logoRenk = returnedBasketballTeam.childSnapshot(forPath: "logoRengi").value as! String
                    
                    let basketballTeam = BasketballTeam(kurucuUID: kurucuUID, takimIsmi: takimIsmi, takimSayisi: takimSayisi, sehir: sehir, baslangicTarih: baslangicTarih, bitisTarihi: bitisTarihi, aciklama: aciklama, kurucuKullanıcıAdı: KurucuKullanıcıAdı, takımSeviyesi: TakımSeviyesi, lokasyonlar: Lokasyonlar, takımKey: takımKey, takımYasOrtalaması: yasOrt, takımLogoIsmi: logoIsmi, takımLogoRenk: logoRenk)
                    
                    basketballTeamArray.append(basketballTeam)
                }
            }
            completion(basketballTeamArray, true)
        })
    }
    
    func createTeamMessage( teamkey : String , content : String , timestamp : String , senderID : String , completion : @escaping (_ succes : Bool)->()){
        
        REF_BASKETBALLTEAM.observeSingleEvent(of: .value, with: { (basketballTeamsSnapshot) in
            
            guard let basketballTeamsSnapshot = basketballTeamsSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for basketballTeam in basketballTeamsSnapshot{
                
                if basketballTeam.key == teamkey{
                    
                    self.getUsername(byUID: senderID, completion: { (username, succes) in
                        if succes{
                            let messageData : [String : String] = ["content" : content , "timestamp" : timestamp , "senderID" : senderID , "username" : username ]
                            
                              self.REF_BASKETBALLTEAM.child(basketballTeam.key).child("messages").childByAutoId().updateChildValues(messageData)
                        }
                    })
                }
            }
            completion(true)
        })
    }
    
    func getTeamMessages(forTeamKey teamKey : String , completion : @escaping (_ messages : [BasketballTeamMessage], _ succes : Bool)->()){
        var messageArray = [BasketballTeamMessage]()
        
        REF_BASKETBALLTEAM.child(teamKey).child("messages").observeSingleEvent(of: .value, with: { (messagesSnapshot) in
            
            guard let messagesSnapshot = messagesSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in messagesSnapshot {
                
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                let timestamp = message.childSnapshot(forPath: "timestamp").value as! String
                let username = message.childSnapshot(forPath: "username").value as! String
                let messageKey = message.key
                
                let message = BasketballTeamMessage(content: content, messageID: messageKey, senderID: senderID, timestamp: timestamp, teamKey: teamKey, senderUsername: username)
                messageArray.append(message)
            }
            completion(messageArray, true)
        })
    }
    
    func getUserName(forUID uid : String , completion : @escaping (_ username : String, _ succes : Bool )->()){
        var username = String()
        
        REF_USERS.observeSingleEvent(of: .value, with: { (usersSnapshot) in
            guard let usersSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else {return}
    
            for user in usersSnapshot{
                if user.key == uid{
                     let returnedUsername = user.childSnapshot(forPath: "username").value as! String
                    username = returnedUsername
                }
            }
            completion(username, true)
        })
    }
    
    func returnUIColorFromString(component: String) -> UIColor {
        //"[0.5, 0.5, 0.5, 1]"
        
        let scanner = Scanner(string: component)
        let skipped = CharacterSet(charactersIn: "[], ")
        let upToComma = CharacterSet(charactersIn: ",")
        // let upTo = CharacterSet(charactersIn : "]")
        
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: upToComma, into: &r)
        
        scanner.scanUpToCharacters(from: upToComma, into: &g)
        
        scanner.scanUpToCharacters(from: upToComma, into: &b)
        
        scanner.scanUpToCharacters(from: upToComma , into: &a)
        
        
        
        guard let rUnwrapped = r else {return UIColor.lightGray}
        
        guard let gUnwrapped = g else {return UIColor.lightGray}
        
        guard let bUnwrapped = b else {return UIColor.lightGray}
        
        guard let aUnwrapped = a else {return UIColor.lightGray}
        
        let rCGFloat = CGFloat(rUnwrapped.doubleValue)
        let gCGFloat = CGFloat(gUnwrapped.doubleValue)
        let bCGFloat = CGFloat(bUnwrapped.doubleValue)
        let aCGFloat = CGFloat(aUnwrapped.doubleValue)
        
        let color = UIColor(red: rCGFloat, green: gCGFloat, blue: bCGFloat, alpha: aCGFloat)
        
        return color
    }
    
    func getTakımKurucuUID(forTeamKey teamKey : String , completion: @escaping (_ kurucuUID : String)->()){
        
        REF_BASKETBALLTEAM.observeSingleEvent(of: .value, with: { (basketballTeamsSnapshot) in
            guard let basketballTeamsSnapshot = basketballTeamsSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for basketballTeam in basketballTeamsSnapshot{
                if basketballTeam.key == teamKey{
                    
                        let kurucUID = basketballTeam.childSnapshot(forPath: "TakımKurucuUID").value as! String!
                    completion(kurucUID!)
                }
            }
            
        })
        
        
    }
    

}















