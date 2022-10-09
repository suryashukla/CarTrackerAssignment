//
//  UserLocationViewController.swift
//  CarTracker
//
//  Created by surya shukla on 03/10/22.
//

import Foundation
import UIKit
import MapKit

class UserLocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var user: UserList?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: SetUp View
    private func setUpView() {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(user?.address?.geoLocation?.latitude ?? "") ?? 0.0, longitude: Double(user?.address?.geoLocation?.longitude ?? "") ?? 0.0)
        annotation.title = user?.userName
        annotation.subtitle = user?.address?.city
        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        // Using custom image(dog) as a Annotation View
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
}
