//
//  EventsViewController.swift
//  MarketChoice
//
//  Created by Cesar Roberto on 19/02/20.
//  Copyright © 2020 CARLOS GABRIEL TORRES PAEZ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var eventsHeaderImg: UIImageView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var eventUbicationMap: MKMapView!
    
    
    
    //alerta
    let confirmAlert = UIAlertController(title: "Telefono", message: "El telefono de esta agencia es 55-23-45-67-89", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Cerrar", style: .cancel, handler: nil)
  //Location manager
    let locationManager = CLLocationManager()
 // Localicaion del mapa
    let pinAnottation = MKPointAnnotation()
 
    



        override func viewDidLoad() {
            super.viewDidLoad()
            
        //Set the "Seguir" button with border and color
            followBtn.layer.borderWidth = 2.0
        //Set the companys profile pic rounded corners to mkae it a circle
            companyImage.layer.borderWidth = 2
            companyImage.layer.cornerRadius = companyImage.frame.size.width/2
            companyImage.layer.masksToBounds = true
        //Set the map layer round
            eventUbicationMap.layer.masksToBounds = false
            eventUbicationMap.layer.cornerRadius = 20
            eventUbicationMap.layer.shadowColor = UIColor.black.cgColor
            eventUbicationMap.layer.shadowRadius = 6
            eventUbicationMap.layer.shadowOpacity = 0.5
            eventUbicationMap.layer.shadowOffset = CGSize(width: 0, height: 3)
            
        //Setting the map ubication
        //Coordenadas para el mapa 19.328580, -99.198214
            //el pin  lo colocamos en la longitud de nuestro taller
            pinAnottation.coordinate = CLLocationCoordinate2D(latitude: 19.328580, longitude: -99.198214)
            //Añadimos el pin al mapa
            eventUbicationMap.addAnnotation(pinAnottation)
            //Centraremos el mapa en una region
            let region = MKCoordinateRegion(center: pinAnottation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            //Añadimos esa region al mapa
            eventUbicationMap.setRegion(region, animated: true)
            pinAnottation.title = "VW México taller Autorizado"
            pinAnottation.subtitle = "Masters de la Reparacion"
            
            
        //Añadiendo acciones a los alerts
            confirmAlert.addAction(cancel)
        //Alerta anidada
            confirmAlert.addAction(UIAlertAction(title: "Horarios", style: .default, handler: { [weak confirmAlert, weak self] (_) in
              let message = "Lun - Vie de 8:00 a 22:00, citas por correo al vw@gmail.com"
                
              let innerAlert = UIAlertController(title: "Horarios de Atencion:", message: message, preferredStyle: .alert)
              innerAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler:nil))
              self?.present(innerAlert, animated: true, completion: nil)
            }))
            
            
            
//        // para obtener la localizacion del usuario
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.distanceFilter = kCLDistanceFilterNone
//            locationManager.startUpdatingLocation()
//            eventUbicationMap.showsUserLocation = true
            
            
         
            
            
        

        }
    
    
    
    @IBAction func confirmAsistBtn(_ sender: Any) {
        DispatchQueue.main.async {
            //Presentamos la alerta al hacer clic sobre mostrar telefono
            self.present(self.confirmAlert, animated: true)
        }
        
    }
    

    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //CollectionViewFunctions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SugestEventCollectionViewCell
        cell.cellEventImage.image = UIImage(named: "carCollection")
        //Celda
            cell.contentView.layer.cornerRadius = 15.0
            cell.contentView.layer.borderWidth = 5.0
        //La celda ocupara su borde tambien
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.backgroundColor = .white
        //Sombra
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowRadius = 5.0
            cell.layer.cornerRadius = 10
            cell.layer.shadowOpacity = 0.4
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }
    
    //Tamaño de la celda
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 247)
    }
   
}








