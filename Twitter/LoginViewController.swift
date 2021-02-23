//
//  LoginViewController.swift
//  Twitter
//
//  Created by Richard Basdeo on 2/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    //Login in button action
    @IBAction func onLoginButton(_ sender: UIButton) {
        
        //url to login
        //https://developer.twitter.com/en/docs/authentication/api-reference/request_token
        let myURL = "https://api.twitter.com/oauth/request_token"
        
        //twitterAPI Class provided by CodePath
        //if successful go to perforom segue
        //set user defaults so app can remember that the user logged in and verified
        TwitterAPICaller.client?.login(url: myURL, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (error) in
           print ("There was an error logging in: \(error)")
        })
    }
}
