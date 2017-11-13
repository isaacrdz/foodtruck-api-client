//
//  MainVC.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/12/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.delegate = self
        
        DataService.instance.getAllFoodTrucks()
    }
}
    
    
extension MainVC: DataServiceDelegate {
  
    func trucksLoaded(){
    }
    
    func reviewsLoaded(){
        
    }
}
   


