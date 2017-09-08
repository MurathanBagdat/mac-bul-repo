//
//  TakımKurmaVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 2.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class Tak_mKurmaVC: UIViewController{
    //Outlets
    @IBOutlet weak var imageView: RoundedImage!
    
    @IBOutlet weak var takimIsmiTextField: UITextField!
    @IBOutlet weak var takimSayısıTextField: UITextField!
    
    @IBOutlet weak var macSeviyesiSecView: ViewWithWhiteBorder!
    @IBOutlet weak var yasOrtalamasıSec: ViewWithWhiteBorder!
    @IBOutlet weak var macSeviyesiSlider: CustomSlider!
    @IBOutlet weak var yasOrtSLider: UISlider!
    
    @IBOutlet weak var ilkButton: UIButton!
    @IBOutlet weak var ikinciButton: UIButton!
    @IBOutlet weak var üçüncüButton: UIButton!
    
    @IBOutlet weak var sehirYazmaView: ViewWithWhiteBorder!
    @IBOutlet weak var sehirYazmaTextField: SearchTextField!
    @IBOutlet weak var pinLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var baslangıcView: ViewWithWhiteBorder!
    @IBOutlet weak var baslangıçHeightConstraing: NSLayoutConstraint!
    @IBOutlet weak var baslangıçDatePciker: CustomDatePicker!
    var isBaslangıcPickerShown = false
    
    @IBOutlet weak var bitisView: ViewWithWhiteBorder!
    @IBOutlet weak var bitişHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bitişDatePicker: CustomDatePicker!
    var isBitisPickerShown = false
    
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var zamanLabel: UILabel!
    
    @IBOutlet weak var collecitionView: UICollectionView!
    
    @IBOutlet weak var ilkButtonBttomConstraint: NSLayoutConstraint!
    
    //Variables
    var takimIsmi = ""
    var takimSayısı = ""
    var sehir = ""
    var takimLogosuRengi = "[0.87, 0.87, 0.87, 1]"
    var globalSeviye = ""
    var globalYas = ""
    
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    let locationManager = CLLocationManager()
    let authStatus = CLLocationManager.authorizationStatus()
    var firstTime = true
    
    var teamLogoName = "image7"
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        
        collecitionView.delegate = self
        collecitionView.dataSource = self
        
        self.baslangıçDatePciker.setValue(UIColor.white, forKey: "textColor")
        self.bitişDatePicker.setValue(UIColor.white, forKey: "textColor")
        
        for i in 0...18{
            
            images.append(UIImage(named: "image\(i)")!)
        }
        
        
        //keyboardStuff#######
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //keyboardStuff#######
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.ikinciSayfayıGizle()
        self.üçüncüSayfayıGizle()
        self.dördüncüSayfayıGizle()
        
        self.imageView.image = UIImage(named: teamLogoName)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        if takimIsmiTextField.text != "" && takimSayısıTextField.text != "" {
            takimIsmi = takimIsmiTextField.text!
            takimSayısı = takimSayısıTextField.text!
            
            birinciSayfayıGizle()
            ikinciSayfayıGöster()
            
            if self.takimIsmiTextField.isFirstResponder{
                takimIsmiTextField.resignFirstResponder()
            }
            if self.takimSayısıTextField.isFirstResponder{
                takimSayısıTextField.resignFirstResponder()
            }
        }else{
            
            if takimIsmiTextField.text == ""{
                self.shakeTheTakımIsmiTextField()
                
            }
            if takimSayısıTextField.text == "" {
                self.shakeTheTakımSayısıTextField()
            }
        }
    }
    @IBAction func ikiniciButtonPrsd(_ sender: Any) {
        
        var seviye : String {
            switch macSeviyesiSlider.value{
            case 1:
                return "Eğlencesine"
            case 2 :
                return "Orta"
            case 3 :
                return "Uzman"
            default:
                return "Orta"
            }
        }
        
        var yaş : String{
            switch yasOrtSLider.value{
            case 1 :
                return "-18"
            case 2 :
                return "18-25"
            case 3 :
                return "25-35"
            case 4 :
                return "35+"
            default:
                return "18-25"
            }
        }
        ikinciSayfayıGizle()
        üçüncüSayfayıGöster()
        
        configureLocationServices()
        centerMapOnUserLocation()
        
        let longPrs = UILongPressGestureRecognizer(target: self, action: #selector(Tak_mKurmaVC.dropAPin(sender:)))
        longPrs.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPrs)
        
        globalSeviye = seviye
        globalYas = yaş
        
    }
    
    @IBAction func ücünücüButtonPrsd(_ sender: UIButton) {
        
        if sehirYazmaTextField.text != "" {
            
            self.sehir = sehirYazmaTextField.text!
            
            if latitude != 0.0 && longitude != 0.0 {
                
                üçüncüSayfayıGizle()
                dördüncüSayfayıGöster()
                
            }else{
                self.shakeTheMapView()
            }
        }else{
            
            self.shakeTheSehirView()
        }
        
    }
    
    @IBAction func dismissButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func seviyeSlider(_ sender: CustomSlider) {
        sender.value = roundf(sender.value)
    }
    
    @IBAction func yasOrtlamasıSecSlider(_ sender: UISlider) {
        self.yasOrtSLider.value = roundf(yasOrtSLider.value)
        
    }
    @IBAction func togglesTheBaslangıcPicker(_ sender: UIButton) {
        
        if isBaslangıcPickerShown == false {
            
            if isBitisPickerShown {
                UIView.animate(withDuration: 0.3, animations: {
                    self.bitişDatePickerSakla()
                })
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.başlangıçDatePickerGöster()
            })
            
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.başlangıçDatePickerSakla()
            })
            
        }
        
    }
    
    @IBAction func togglesTheBitisPicker(_ sender: UIButton) {
        
        if isBitisPickerShown == false{
            if isBaslangıcPickerShown{
                UIView.animate(withDuration: 0.3, animations: {
                    self.başlangıçDatePickerSakla()
                })
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.bitişDatePickerGöster()
            })
            
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.bitişDatePickerSakla()
            })
        }
        
    }
    @IBAction func baslangıçDatePickerValueChanged(_ sender: CustomDatePicker) {
        self.bitişDatePicker.date = baslangıçDatePciker.date.addingTimeInterval(7200)
        self.bitişDatePicker.minimumDate = baslangıçDatePciker.date
        
    }
    @IBAction func pickAnAvatar(_ sender: UIButton) {
        
        if self.collecitionView.alpha == 0{
            UIView.animate(withDuration: 0.3, animations: {
                self.collecitionView.alpha = 1
            })
        }
        
    }
    
    
    
    
    @IBAction func arkaPlanaRenkVer(_ sender: UIButton) {
        let r  = CGFloat(arc4random_uniform(255)) / 255
        let g  = CGFloat(arc4random_uniform(255)) / 255
        let b  = CGFloat(arc4random_uniform(255)) / 255
        
        self.takimLogosuRengi = "[\(r), \(g), \(b), 1]"
        
        
        UIView.animate(withDuration: 0.2) {
            self.imageView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        }
        
    }
    
    @IBAction func takımıKurButtonPrsd(_ sender: UIButton) {
        
        let baslangıcDate = self.baslangıçDatePciker.date
        let bitişDate = self.bitişDatePicker.date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        let baslangıcDateInString = formatter.string(from: baslangıcDate)
        let bitisDateInString = formatter.string(from: bitişDate)
        
        
        DatabaseService.instance.getUsername(byUID: (Auth.auth().currentUser?.uid)!) { (username, succes) in
            if succes{
                
                let basketballTeam = BasketballTeam(kurucuUID: Auth.auth().currentUser?.uid, takimIsmi: self.takimIsmi, takimSayisi: self.takimSayısı, sehir: self.sehir, baslangicTarih: baslangıcDateInString, bitisTarihi: bitisDateInString,kurucuKullanıcıAdı: username, takımSeviyesi: self.globalSeviye, takımKey: nil, takımYasOrtalaması: self.globalYas, takımLogoIsmi: self.teamLogoName, takımLogoRenk: self.takimLogosuRengi, teamLat: self.latitude, teamLong: self.longitude)
                
                DatabaseService.instance.createBasketballTeam(withBasketballTeam: basketballTeam, completion: { (succes) in
                    if succes{
                        
                        if self.firstTime {
                            
                            
                            
                            let alertController = UIAlertController(title: "Tebrikler İlk Takımını Kurdun!!", message: "Takım bilgilerini istediğin zaman güncelliyebilirsin şimdi takım sohbet odana gidip rakiplerle konuşma vakti", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: { (action) in
                                // self.firsTime = false
                                self.dismiss(animated: true, completion: nil)
                            })
                            
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                            
                        }
                        
                    }
                })
            }
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension Tak_mKurmaVC : MKMapViewDelegate{
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
        
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9542024732, green: 0.5849738717, blue: 0.1916683316, alpha: 1)
        pinAnnotation.image = #imageLiteral(resourceName: "boldBasketball-1")
        pinAnnotation.animatesDrop = true
        
        
        return pinAnnotation
    }
    
    func centerMapOnUserLocation(){
        removeAnnot()
        guard let coordinat = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinat, 3000 , 3000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func dropAPin(sender : UIGestureRecognizer) {
        removeAnnot()
        let touchPoint = sender.location(in: self.mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        let annotation = PinWithImage(coordinate: touchCoordinate, identifier: "customPin")
        
        self.mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        self.latitude = touchCoordinate.latitude
        self.longitude = touchCoordinate.longitude
        print("called")
    }
    
    func removeAnnot(){
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
    }
}

extension Tak_mKurmaVC : CLLocationManagerDelegate{
    
    func configureLocationServices(){
        
        if authStatus == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }else{
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}
extension Tak_mKurmaVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "takımKurAvatarCell", for: indexPath) as? AvatarPickerCell else {return UICollectionViewCell()}
        
        let image = images[indexPath.row]
        
        cell.configureCell(avatarImage: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumn : CGFloat = 3
        
        if UIScreen.main.bounds.width > 320{
            numberOfColumn = 4
        }
        
        let padding : CGFloat = 40
        
        let spaceBetweenCell : CGFloat = 10
        
        let cellDimension = (UIScreen.main.bounds.width - padding - (spaceBetweenCell*numberOfColumn))/numberOfColumn
        
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.collecitionView.alpha == 1{
            
            let selectedImageName = "image\(indexPath.item)"
            self.imageView.image = UIImage(named : selectedImageName)
            self.teamLogoName = selectedImageName
            
            UIView.animate(withDuration: 0.3, animations: {
                self.collecitionView.alpha = 0
            })
        }
    }
}















