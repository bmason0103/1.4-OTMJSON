//
//  AddLink.swift
//  On The Map
//
//  Created by Brittany Mason on 10/2/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class addLink : UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var fullMapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let vc = addLocation()
        //        vc.dismiss(animated:true,completion:nil)
        
        // Do any additional setup after loading the view.
        populateMapView()
    }
    
    @IBAction func cancelButtons(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    private func populateMapView(){
        
        var annotations = [MKPointAnnotation]()
        let locationResponse = fullLocationResponse.LocationResponse()
        let lat =  CLLocationDegrees(locationResponse.latitude)
        let lon = CLLocationDegrees(locationResponse.longitude)
        //        let lat = CLLocationDegrees(parametersAll.StudentLocation.latitude)
        //        let lon = CLLocationDegrees(parametersAll.StudentLocation.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        let firstname = parametersAll.StudentLocation.publicfirstName
        let lastname = parametersAll.StudentLocation.publiclastName
        
        annotation.title = "\(firstname) \(lastname)"
        
        annotation.subtitle = parametersAll.StudentLocation.mediaURL
        annotations.append(annotation)
        
        /* Zoom into a specific region */
        let span = MKCoordinateSpan.init(latitudeDelta: 0.5, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        performUIUpdatesOnMain {
            self.fullMapView.addAnnotations(annotations)
            self.fullMapView.setRegion(region, animated: true)
            print("New location added to the Map View.")
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        taskPostStudentLocation{ (results, error) in
            
            if (error != nil) {
                performUIUpdatesOnMain {
                    
                    self.displayAlert(title: "Error", message: "The was a problem submitting your location")
                }
                print(error as Any)
            } else {
               performUIUpdatesOnMain { if let objectId = results {
                    parametersAll.StudentLocation.objectId = objectId
                    print(objectId)
              
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "mapView")
                    self.present(controller, animated: true, completion: nil)
                   
                }
                print("successfully added")
            }
        }
    }
    
    }
    
    
    
    
}
