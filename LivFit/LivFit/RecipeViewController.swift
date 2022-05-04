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
        
        let totalNutrients = recipe["totalNutrients"] as! [String:Any]?
        let protein = totalNutrients?["PROCNT"] as! [String:Any]?
        let fat = totalNutrients?["FAT"] as! [String:Any]?
        let carb = totalNutrients?["CHOCDF"] as! [String:Any]?
        let p = String(format: "%@", protein?["quantity"] as! CVarArg)
        let f = String(format: "%@", fat?["quantity"] as! CVarArg)
        let c = String(format: "%@", carb?["quantity"] as! CVarArg)

        let labels = recipe["healthLabels"] as! [String]
        var healthLabels = ""
        
        for label in labels {
            healthLabels += label + ", "
        }
        
        self.dishNameLabel.text = recipe["label"]! as? String
        self.healthLabel.text = healthLabels
        self.numOfServingsLabel.text = String(format: "%@", recipe["yield"] as! CVarArg)
        self.calAmountLabel.text = String(format: "%@", recipe["calories"] as! CVarArg)
        self.proteinAmountLabel.text = p
        self.fatAmountLabel.text = f
        self.carbAmountLabel.text = c
        
        let imageURL = URL(string: recipe["image"] as! String)
        recipeView.af.setImage(withURL: imageURL!)
        
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
