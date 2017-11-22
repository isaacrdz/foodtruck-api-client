//
//  ReviewCell.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/21/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(review: FoodTruckReview){
        titleLabel.text = review.title
        reviewTextLabel.text = review.text
    }
  
}
