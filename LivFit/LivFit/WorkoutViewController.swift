//
//  WorkoutViewController.swift
//  LivFit
//
//  Created by Steven Schreiber on 4/26/22.
//

import UIKit

class WorkoutViewController: UIViewController {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var equipmentListLabel: UILabel!
    @IBOutlet weak var workoutView: UIImageView!
    
    var workout: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.workoutNameLabel.text = workout["name"] as? String
        self.bodyPartLabel.text = workout["bodyPart"] as? String
        self.targetLabel.text = workout["target"] as? String
        self.equipmentListLabel.text = workout["equipment"] as? String
        
        var gifURL: String = workout["gifUrl"] as! String
        gifURL.insert("s", at: gifURL.index(gifURL.startIndex, offsetBy: 4))
        print(gifURL)
        let image = UIImage.gifImageWithURL(gifURL)
        self.workoutView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
