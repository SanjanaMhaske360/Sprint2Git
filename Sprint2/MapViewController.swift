//
//  MapViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/22/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate{

    //mapView variable
    @IBOutlet weak var mapView: MKMapView!
    //CLLocation Manager variable
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        
        //reuestWhenInUseAuthorization function call for getting a request of perimission from customer
        manager.requestWhenInUseAuthorization()
        
        //startUpdatingLocation Function call for Updating Location
        manager.startUpdatingLocation()
    }
    
    //MARK: Location Manger function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            //Update Location
            manager.stopUpdatingLocation()
            CustomerLocation(location)
        }
    }
    
    //MARK: CustomerLocation function
    func CustomerLocation(_ location: CLLocation) {
        
        // Location Coordinate As Latitude And longitude
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        
        //Coordinate span latitude and Longitude
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        // Region With Center And Span
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        //set a region
        mapView.setRegion(region , animated: true)
        
        //pin to the Location
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
    }
    
    // Action To the Buy Now Button
    @IBAction func  imagebtn(_ sender: Any) {
       print("Buy Now btn Clicked ")
        
        // Navigate To LocalNotificationViewController 
        let notificationVC = self.storyboard?.instantiateViewController(withIdentifier:"LocalNotificationViewController") as! LocalNotificationViewController
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
}
