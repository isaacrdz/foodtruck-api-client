//
//  MainVC.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/12/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataService = DataService.instance
    var authService = Authservice.instance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        dataService.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 120
        
        DataService.instance.getAllFoodTrucks()
    }
    
}

extension MainVC: DataServiceDelegate {
    func trucksLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    func reviewsLoaded() {
        // Do nothing
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.foodTrucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTruckCell", for: indexPath) as? FoodTruckCell {
            cell.configureCell(truck: dataService.foodTrucks[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
