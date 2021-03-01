//
//  TweetViewController.swift
//  Twitter
//
//  Created by Richard Basdeo on 3/1/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Show keyboard as soon as the screen loads
        tweetTextView.becomeFirstResponder()
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        //get rid of viewController
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweetPressed(_ sender: UIBarButtonItem) {
        
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print ("There was an error posting tweet, \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else {
            //Shold make an alert to put some text
        }
    }
}
