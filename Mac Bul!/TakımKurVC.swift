//
//  TakımKurVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 28.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class Tak_mKurVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func DatepickerDate(_ sender: UIDatePicker) {
        print(datePicker.date)
    }


}
