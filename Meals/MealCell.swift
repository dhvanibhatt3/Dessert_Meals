//
//  MealCell.swift
//  Meals
//
//  Created by Dhvani Bhatt on 12/5/22.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
