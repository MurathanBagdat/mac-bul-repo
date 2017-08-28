//
//  SecimVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 27.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class SecimVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func futbolSelected(_ sender: UIButton) {
        performSegue(withIdentifier: "toFootball", sender: nil)
    }
    @IBAction func basketballSecildi(_ sender: UIButton) {
        performSegue(withIdentifier: "toBasketball", sender: nil)
    }

}
