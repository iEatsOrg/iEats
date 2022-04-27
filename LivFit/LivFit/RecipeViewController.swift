//
//  RecipeViewController.swift
//  iEats
//
//  Created by Steven Schreiber on 4/12/22.
//

import UIKit
import AlamofireImage

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var numOfServingsLabel: UILabel!
    @IBOutlet weak var calAmountLabel: UILabel!
    @IBOutlet weak var proteinAmountLabel: UILabel!
    @IBOutlet weak var fatAmountLabel: UILabel!
    @IBOutlet weak var carbAmountLabel: UILabel!
    
    @IBOutlet weak var moreInfoLink: UITextView!
    @IBOutlet weak var getRecipeLink: UITextView!
    
    @IBOutlet weak var recipeView: UIImageView!
    
    var recipe: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        API setup to grab recipe
        let url = URL(string: "https://api.edamam.com/api/recipes/v2/b79327d05b8e5b838ad6cfd9576b30b6?type=public&app_id=bae79dc0&app_key=6f9f2700d9cde993e68d9596657afe36")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                var healthLabels = ""

                self.recipe = dataDictionary["recipe"] as! [String:Any]?
                
                let labels = self.recipe["healthLabels"] as! [String]
                
                for label in labels {
                    healthLabels += label
                }
                                  
                self.dishNameLabel.text = self.recipe["label"]! as? String
                self.healthLabel.text = healthLabels
                
                
                let imageURL = URL(string: self.recipe["image"] as! String)
                self.recipeView.af.setImage(withURL: imageURL!)

             }
        }
        task.resume()
        
        updateMoreInfo()
        updateGetRecipe()
    }
        
    func updateMoreInfo() {
        let path = "https://www.edamam.com/results/recipe/?recipe=chicken-vesuvio-b79327d05b8e5b838ad6cfd9576b30b6/?search=-"
        let text = moreInfoLink.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "More Info!")
        let font = moreInfoLink.font
        
        moreInfoLink.attributedText = attributedString
        moreInfoLink.font = font
    }
    func updateGetRecipe() {
        let path = "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html"
        let text = getRecipeLink.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Get Recipe!")
        let font = getRecipeLink.font
        
        getRecipeLink.attributedText = attributedString
        getRecipeLink.font = font
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
