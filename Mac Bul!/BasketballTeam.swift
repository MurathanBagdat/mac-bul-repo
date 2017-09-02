//
//  BasketballTeam.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import MapKit

//enum TakımSeviyesi
//{
//    case acemi
//    case orta
//    case uzman
//}


struct BasketballTeam {
    
    public private(set) var kurucuUID : String!
    public private(set) var takimIsmi : String!
    public private(set) var takimSayisi : String!
    public private(set) var sehir : String!
    public private(set) var baslangicTarih : String!
    public private(set) var bitisTarihi : String!
    public private(set) var kurucuKullanıcıAdı : String!
    public private(set) var takımSeviyesi : String!
    public private(set) var takımKey : String?
    public private(set) var takımYasOrtalaması : String!
    public private(set) var takımLogoIsmi : String!
    public private(set) var takımLogoRenk : String!
    public private(set) var teamLat : CLLocationDegrees!
    public private(set) var teamLong : CLLocationDegrees!
    
}
struct AdamArayanBasketballTeam {
    
    public private(set) var kurucuUID : String!
    public private(set) var takimIsmi : String!
    public private(set) var takimSayisi : String!
    public private(set) var sehir : String!
    public private(set) var baslangicTarih : String!
    public private(set) var bitisTarihi : String!
    public private(set) var aciklama : String!
    public private(set) var kurucuKullanıcıAdı : String!
    public private(set) var takımSeviyesi : String!
    public private(set) var lokasyonlar : String!
    public private(set) var takımKey : String?
    public private(set) var takımYasOrtalaması : String!
    public private(set) var takımLogoIsmi : String!
    public private(set) var takımLogoRenk : String!
    public private(set) var kaçAdamArıyor : Int!
    
}
