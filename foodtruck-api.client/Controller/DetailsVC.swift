//
//  DetailsVC.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/18/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {
    
    var selectedFoodTruck: FoodTruck?
    var logInVC: LogInVC?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedFoodTruck?.name
        foodTypeLabel.text = selectedFoodTruck?.foodType
        avgCostLabel.text = "$\(selectedFoodTruck!.avgCost)"

        mapView.addAnnotation(selectedFoodTruck!)
        centerMapOnLocation(CLLocation(latitude: selectedFoodTruck!.lat, longitude: selectedFoodTruck!.long))
    }

    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(selectedFoodTruck!.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }

    
    
   
    
   
    
   
    
   
}
