//
//  RecipeCell.swift
//  iEats
//
//  Created by Michael Velasquez on 4/12/22.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var foodLabelOne: UILabel!
    @IBOutlet weak var foodLabelTwo: UILabel!
    @IBOutlet weak var calAmountLabel: UILabel!
    @IBOutlet weak var dishView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
