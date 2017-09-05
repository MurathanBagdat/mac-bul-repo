//
//  pinWithImage.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 2.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import MapKit


class PinWithImage : NSObject , MKAnnotation{
    
    var coordinate : CLLocationCoordinate2D
    var identifier : String
    
    init(coordinate : CLLocationCoordinate2D, identifier : String){
        
        self.coordinate = coordinate
        self.identifier = identifier
        
    }
    
    
}
