//
//  ViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit

//ViewController Class - Starting screen
class ViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var AdminButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var AboutButton: UIButton!
    
    //Function- view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up the style of the view
        setUpElements()
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //Action Function- Admin pressed
    @IBAction func AdminPressed(_ sender: UIButton) {
        //alert asking login or signup
        let alert = UIAlertController(title: "Admin", message: "What would you like to do", preferredStyle: UIAlertController.Style.alert)
        
        let loginAction = UIAlertAction(title: "Login", style: .default){
        (action:UIAlertAction!)in
            let LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.LoginViewController) as? LoginViewController
            LoginViewController?.admin = true
            self.view.window?.rootViewController = LoginViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        let signUpAction = UIAlertAction(title: "Sign Up", style: .default){
        (action:UIAlertAction!)in
            let SignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.SignUpViewController) as? SignUpViewController
            SignUpViewController?.admin = true
            self.view.window?.rootViewController = SignUpViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
        (action:UIAlertAction!)in
        }
        
        alert.addAction(loginAction)
        alert.addAction(signUpAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action Function- information about the app
    @IBAction func AboutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "About", message: "Wellbeing and Mindful Healthy Habits is a mobile application which is a tool to help improve a sense of wellbeing. The different functions of the app include journaling, breathing exercises, grounding techniques, sleep and exercise logging, meditation, along with some helpful tips to improve wellbeing. Please sign up to the application or login!", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Sets up the style for the view elements
    func setUpElements(){
        StyleSheet.styleFilledButtonLevel1(SignUpButton)
        StyleSheet.styleInvertFilledButtonLevel1(LoginButton)
        StyleSheet.styleFilledButtonLevel1(AdminButton)
        StyleSheet.styleInvertFilledButtonLevel1(AboutButton)
    }
}
