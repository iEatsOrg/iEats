//
//  WorkoutsViewController.swift
//  LivFit
//
//  Created by Steven Schreiber on 5/3/22.
//

import UIKit

class WorkoutsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var workouts = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let headers = [
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "X-RapidAPI-Key": "e882830a13msha4af5fd2d5dde9bp1229edjsn899c6840c6a2"
        ]
        
        let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                self.workouts = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell") as! WorkoutTableViewCell
        let workout = workouts[indexPath.row]
        
        let workoutNameLabel = workout["name"] as? String
        let bodyPartLabel = workout["bodyPart"] as? String
        let targetLabel = workout["target"] as? String

        cell.workoutNameLabel.text = workoutNameLabel
        cell.bodyPartLabel.text = bodyPartLabel
        cell.targetLabel.text = targetLabel

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        print("Loading up the details screen")

        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let workout = workouts[indexPath.row]

        let detailsViewController = segue.destination as! WorkoutViewController
        detailsViewController.workout = workout

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
