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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headers = [
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "X-RapidAPI-Key": "e882830a13msha4af5fd2d5dde9bp1229edjsn899c6840c6a2"
        ]
        
        let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises/exercise/0001")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
               print(error.localizedDescription)
            } else if let data = data {
               let workout = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                print(workout)
                
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
        }

        task.resume()
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
