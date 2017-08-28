//
//  AuthService.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import FirebaseAuth



class AuthService {
    
    static let instance = AuthService()
    
    
    func signInUser(withEmail email : String , andPassword password : String, completionHandler : @escaping (_ succes : Bool, _ error : Error?)->()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                completionHandler(false, error)
            }
            completionHandler(true, nil)
        }
    }
    
    func createUser(withEmail email : String , andPassword password : String, username : String , completionHandler : @escaping (_ succes : Bool, _ error : Error?)->()){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if user == nil {
                completionHandler(false, error)
                return
            }
            completionHandler(true, nil)
            let userData = ["email" : email, "username" : username]
            DatabaseService.instance.createUserInDB(withUID: (user?.uid)!, userData: userData, completion: { (succes) in
                if succes{
                    print("1 kullancı eklendi")
                }
            })
        }
    }
}
