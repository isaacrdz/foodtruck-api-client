//
//  AddReviewVC.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/21/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import UIKit

class AddReviewVC: UIViewController {

    var selectedFoodTruck: FoodTruck?
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var reviewTitleLabel: UITextField!
    @IBOutlet weak var reviewTextLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let truck = selectedFoodTruck {
            headerLabel.text = truck.name
        } else {
            headerLabel.text = "Error"
        }
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let truck = selectedFoodTruck else {
            showAlert(with: "Error", message: "Could not  get selected truck")
            return
        }
        
        guard let title = reviewTitleLabel.text, reviewTitleLabel.text != "" else {
            showAlert(with: "Error", message: "Please enter a title for your review")
            return
        }
        
        guard let reviewText = reviewTextLabel.text, reviewTextLabel.text != ""  else {
            showAlert(with: "Error", message: "Plase enter a text for you review")
            return
        }
        DataService.instance.addNewReview(truck.id, title: title, text: reviewText, completion: {Success in
            if Success {
                print("Saved succesfully")
                DataService.instance.getAllReviews(for: truck)
                self.dismiss(animated: true, completion: nil)
            } else {
                 self.showAlert(with: "Error", message: "Error occurred saving the new review")
                print("Save was unsuccesful")
            }
        })
        
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    func showAlert(with title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
  
}
