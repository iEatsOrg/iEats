//
//  WorkoutTableViewCell.swift
//  LivFit
//
//  Created by Steven Schreiber on 5/3/22.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
