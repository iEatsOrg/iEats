//
//  RecipesViewController.swift
//  LivFit
//
//  Created by Steven Schreiber on 5/3/22.
//

import UIKit
import AlamofireImage

class RecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var recipes = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=healthy&app_id=bae79dc0&app_key=6f9f2700d9cde993e68d9596657afe36")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.recipes = dataDictionary["hits"] as! [[String:Any]]
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as! RecipeCell
        let intermediate = recipes[indexPath.row]
        let recipe = intermediate["recipe"] as! NSDictionary
        print(recipe["label"]!)
        let labels = recipe["healthLabels"] as! [String]

        let dishNameLabel = recipe["label"] as! String
        let foodLabelOne = labels[0]
        let foodLabelTwo = labels[1]
        let calAmountLabel = String(format: "%@", recipe["calories"] as! CVarArg)

        cell.dishNameLabel.text = dishNameLabel
        cell.foodLabelOne.text = foodLabelOne
        cell.foodLabelTwo.text = foodLabelTwo
        cell.calAmountLabel.text = calAmountLabel

        let imageURL = URL(string: recipe["image"] as! String)
        cell.dishView.af.setImage(withURL: imageURL!)

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        print("Loaading up the details screen")

        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let recipe = recipes[indexPath.row]

        let detailsViewController = segue.destination as! RecipeViewController
        detailsViewController.recipe = recipe

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
