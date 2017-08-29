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
        
        REF_BASKETBALLTEAM.childByAutoId().updateChildValues(["Takımİsmi" : basketballTeam.takimIsmi , "TakımKurucuUID" : basketballTeam.kurucuUID , "TakımSeviyesi" : basketballTeam.takımSeviyesi, "TakımSayısı" : basketballTeam.takimSayisi , "Sehir" : basketballTeam.sehir, "Lokasyonlar" : basketballTeam.lokasyonlar, "KurucuKullanıcıAdı" : basketballTeam.kurucuKullanıcıAdı, "BaslangıçTarihi" : basketballTeam.baslangicTarih, "BitişTarihi" : basketballTeam.bitisTarihi, "EkstraAçıklamalar" : basketballTeam.aciklama])
        
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
                
                
                let basketballTeam = BasketballTeam(kurucuUID: kurucuUID, takimIsmi: takimIsmi, takimSayisi: takimSayisi, sehir: sehir, baslangicTarih: baslangicTarih, bitisTarihi: bitisTarihi, aciklama: aciklama, kurucuKullanıcıAdı: KurucuKullanıcıAdı, takımSeviyesi: TakımSeviyesi, lokasyonlar: Lokasyonlar, takımKey: takımKey)
                
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
            
                    let basketballTeam = BasketballTeam(kurucuUID: kurucuUID, takimIsmi: takimIsmi, takimSayisi: takimSayisi, sehir: sehir, baslangicTarih: baslangicTarih, bitisTarihi: bitisTarihi, aciklama: aciklama, kurucuKullanıcıAdı: KurucuKullanıcıAdı, takımSeviyesi: TakımSeviyesi, lokasyonlar: Lokasyonlar, takımKey: takımKey)
        
                    basketballTeamArray.append(basketballTeam)
                }
            }
            completion(basketballTeamArray, true)
        })
    }
}















