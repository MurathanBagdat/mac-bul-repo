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
    
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    
    func createUserInDB(withUID uid : String, userData : Dictionary<String, Any> , completion : (_ succes: Bool)->()){
        
        REF_USERS.childByAutoId().updateChildValues(userData)
        completion(true)
        
    }
    
    
    
}
