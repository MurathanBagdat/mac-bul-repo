//
//  UserdataService.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 31.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import UIKit



class UserdataService{
    
    let instance = UserdataService()
    
    let defaults = UserDefaults.standard
    
    
    
    var takimLogosuIsmi :String{
        set{
            defaults.set(takimLogosuIsmi, forKey: "takımlogosu")
        }
        get{
            return defaults.value(forKey: "takımlogosu") as! String
        }
    }
    
    
    
    
    
    
}
