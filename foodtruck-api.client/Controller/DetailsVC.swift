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

    @IBAction func reviewsButtonTapped(sender: UIButton){
        performSegue(withIdentifier: "showReviewsVC", sender: self)
    }
    
    @IBAction func addReviewButtonTapped(_ sender: UIButton) {
        if AuthService.instance.isAuthenticated == true {
            performSegue(withIdentifier: "showAddReviewVC", sender: self)
        } else {
            showLogIn()
        }
    }
    
    func showLogIn(){
        logInVC = LogInVC()
        logInVC?.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(logInVC!, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReviewsVC"{
            let destinationViewController = segue.destination as! ReviewsVC
            destinationViewController.selectedFoodTruck = selectedFoodTruck
        } else if segue.identifier == "showAddReviewVC"{
            let destinationViewController = segue.destination as! AddReviewVC
            destinationViewController.selectedFoodTruck = selectedFoodTruck
        }
    }
    
   
    
   
    
   
}
