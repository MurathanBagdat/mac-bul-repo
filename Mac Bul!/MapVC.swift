//
//  MapVC.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 1.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let authStatus = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        centerMapOnUserLocation()
        
        DatabaseService.instance.getBasketballTeamsFeed { (basketballteams) in
            
            for basketballteam in basketballteams{
                

                let coordinate = CLLocationCoordinate2D(latitude: basketballteam.teamLat, longitude: basketballteam.teamLong)
                let title = basketballteam.takimIsmi
                
                let myAnnotation1: Annotation = Annotation(coordinates: coordinate, title1: title!, description: basketballteam.kurucuKullanıcıAdı, imgURL: basketballteam.takımLogoIsmi, teamKey: basketballteam.takımKey!)
                
                self.mapView.addAnnotation(myAnnotation1)
            
            }
        }
    }

    @IBAction func closeButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension MapVC : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        
        
        
        let AnnotationIdentifier = "AnnotationIdentifier"
        
        let myAnnotation1 = (annotation as! Annotation)
        
        
        let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationIdentifier)
        pinView.canShowCallout = true
        pinView.image = UIImage(named: myAnnotation1.strImgUrl)!
    
        return pinView
        
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation{
            return
        }
            let selectedAnnot = mapView.selectedAnnotations.first as! Annotation
            let selectedTeamKey =  selectedAnnot.teamKey
            var selectedTeam = BasketballTeam()
        
       
        
            DatabaseService.instance.getBasketballTeam(forKey: selectedTeamKey) { (basketballTeam, succes) in
                if succes{
                    selectedTeam = basketballTeam
                    
                    let destVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamChatVC") as! TeamChatVC
                    destVC.initTeam(team: selectedTeam)
                    destVC.takımKurucuUID = selectedTeam.kurucuUID
                    self.present(destVC, animated: true, completion: nil)
                    
                }else{
                    print("error12")
                }
        }
    }
    
    func showChatVC(){
        print("tapped")
    }
    
    
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 5000.0, 5000.0)
            mapView.setRegion(coordinateRegion, animated: true)
    }
    
}

extension MapVC : CLLocationManagerDelegate{
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
