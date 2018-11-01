//
//  MapView.swift
//  Miaou Adventures
//
//  Created by Sebastien Larue on 15/10/2018.
//  Copyright © 2018 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import MapKit
import CoreLocation

class MapView : SKScene, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var locationManager:CLLocationManager!
    var mapView:MKMapView!
    var mapBackBtn = SKSpriteNode()
    var mapBanner = SKShapeNode()
    
    override func didMove(to view: SKView) {
        
        //create the map view
        createMapView()
        //function to determine the location
        determineCurrentLocation()
        //add map back button
        createMapBackBtn()
        //add banner
        createMapBanner()
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if let touch = touches.first{
            
            if mapBackBtn.contains(touch.location(in: self)){
                mapBackBtn.setScale(1.2)
                mapView.removeFromSuperview()
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .right, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            
            if mapBackBtn.contains(touch.location(in: self)){
                mapBackBtn.setScale(1.0)
            }
        }
    }
    
    //Creates the map
    func createMapView(){
        mapView = MKMapView()
        mapView.frame = CGRect(x: 0, y: 70, width: self.size.width, height: self.size.height)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view?.addSubview(mapView)
    }
    
    //Determines the player position
    func determineCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location with coordinates
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = NSLocalizedString("mapscore", comment: "")
        myAnnotation.subtitle = "Latitude " + (String(format: "%.2f", latitude) + ", Longitude " + String(format: "%.2f", longitude))
        mapView.addAnnotation(myAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Error \(error)")
    }
}
