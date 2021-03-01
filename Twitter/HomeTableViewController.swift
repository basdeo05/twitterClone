//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Richard Basdeo on 2/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    //to have the refresh when pulling down need to have a refresh controll
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        /*
         -want to add a target for refresh control
         -what action I want to tie to this refresh control
         -Target is where I want this to happen
         -I want this to happen in this screen so will be self
         -Selector/action means what do you want us to do.
         -Have to turn load tweets function to a object c load tweets function
         -Value changed is for the pull down method
         -Give the table view the action
         -Stop the wheel inside the closure method after table view has been loaded
        */
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        //making tableview cell dynamic in height
        //this row height will be automatically calculated
        //give tableview projected rowHeight to start with but if its smaller are larger will be changed.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    
    
    @objc func loadTweets(){
        //determine how many tweets to load
        numberOfTweets = 20
        
        //url to make request
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        //paramaters for request
        // can add more parameters by putitng ,
        let myParams = ["count": numberOfTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams,
                                                        
                                                        success: { (tweets: [NSDictionary]) in
                                                            
                                                            self.tweetArray.removeAll()
                                                            
                                                            for tweet in tweets {
                                                               self.tweetArray.append(tweet)
                                                           }
                                                            self.tableView.reloadData()
                                                            //stopping the refresh
                                                            self.myRefreshControl.endRefreshing()
                                                            
                                                        }, failure: { (error) in
                                                            print ("Could not retreive tweets")
                                                        })
    }
    
    
    //endless scrolling function
    func loadMoreTweets() {
        //same url as before
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        //change number of tweets to load
        numberOfTweets = numberOfTweets + 20
        
        //paramaters for request
        // can add more parameters by putitng ,
        let myParams = ["count": numberOfTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams,
                                                        
                                                        success: { (tweets: [NSDictionary]) in
                                                            
                                                            self.tweetArray.removeAll()
                                                            
                                                            for tweet in tweets {
                                                               self.tweetArray.append(tweet)
                                                           }
                                                            self.tableView.reloadData()
                                                            
                                                            
                                                        }, failure: { (error) in
                                                            print ("Could not retreive tweets")
                                                        })
    }
    

    
    //when user clicks logout button
    @IBAction func onLogout(_ sender: UIBarButtonItem) {
        TwitterAPICaller.client?.logout()
        //screen will dismiss itself
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.tweetsContent.text = tweetArray[indexPath.row]["text"] as? String
        cell.userNameLabel.text = user["name"] as? String
        
        //how to get image
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        
        
        
        
        
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    //method used to call load more tweets function
    //when get to end of page run loadMoreTweets
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row  == tweetArray.count - 1{
            loadMoreTweets()
        }
        
    }
}
