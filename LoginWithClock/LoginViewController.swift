//
//  LoginViewController.swift
//  LoginWithClock
//
//  Created by Amith on 22/01/25.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UserDefaults.standard.bool(forKey: "isLoggedIn"){
            navigateToDashboard()
        }
    }
    func navigateToDashboard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashbordViewController") as? DashbordViewController{
            dashboardVC.modalPresentationStyle = .fullScreen
            self.present(dashboardVC, animated: true, completion: nil)
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else { 
            let alert = UIAlertController(title: "Input Error",message: "Please enter username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if authenticateUser(username: username, password: password){
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashbordViewController") as? DashbordViewController{
                dashboardVC.username = username
                dashboardVC.modalPresentationStyle = .fullScreen
                self.present(dashboardVC, animated: true, completion: nil)
            }
        }else{
                let alert = UIAlertController(title: "LoginFailed", message: "Invalid Credentials", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    
    
    
    func authenticateUser(username: String, password: String) -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        do {
            let users = try context.fetch(fetchRequest)
            return users.count > 0
        } catch {
            print("Error fetching users: \(error)")
            return false
        }
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
