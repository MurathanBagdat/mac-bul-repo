//
//  CustomPin.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 1.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import MapKit


class Annotation : NSObject , MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
    
    var strTitle = ""
    var strImgUrl = ""
    var strDescr = ""
    
    var teamKey = ""
    
    
    init(coordinates location: CLLocationCoordinate2D, title1: String, description: String, imgURL: String, teamKey : String) {
        super.init()
        
        coordinate = location
        title = title1
        subtitle = description
        strTitle = title1
        strImgUrl = imgURL
        strDescr = description
        self.teamKey = teamKey
    }
}
