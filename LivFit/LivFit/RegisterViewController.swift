//
//  RegisterViewController.swift
//  iEats
//
//  Created by Aundre Labrador on 4/12/22.
//

import UIKit
import Parse
class RegisterViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user["name"] = nameField.text
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground{(success, error) in if success{
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
