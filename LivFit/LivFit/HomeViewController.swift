//
//  HomeViewController.swift
//  LivFit
//
//  Created by Aundre Labrador on 5/10/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        
        PFUser.logOut()
        let main = UIStoryboard (name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window? .rootViewController = loginViewController
        
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
