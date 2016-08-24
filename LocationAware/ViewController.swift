//
//  ViewController.swift
//  LocationAware
//
//  Created by 李宝明 on 16/8/24.
//  Copyright © 2016年 李宝明. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var adminCity: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longtitude: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    

    
    var locationManger = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        zipCode.text = ""
        adminCity.text = ""
        
 
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        
        latitude.text = "\(userLocation.coordinate.latitude)"
        longtitude.text = "\(userLocation.coordinate.longitude)"
        speed.text = "\(userLocation.speed)"
        course.text = "\(userLocation.course)"
        
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placeMark, error) in
            if error  != nil {
                print(error)
            }else {
                
                
                
                if let placeMarkData = placeMark?[0] {
                    
                   
                    if let countryData = placeMarkData.country {
                        self.country.text = "\(countryData)"
                    }
                    
                    if let zipCodeData = placeMarkData.postalCode {
                        self.zipCode.text = "\(zipCodeData)"
                    }
                    
                    if let sub = placeMarkData.thoroughfare, let sublocality = placeMarkData.subLocality   {
                        self.address.text = "\(sub) \(sublocality)"
                    }
                    
                    if let sub = placeMarkData.administrativeArea {
                        self.adminCity.text = "\(sub)"
                    }
                    
                    
                }
            }
        }
    }

}

