//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Richard Basdeo on 2/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetsContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var didLike = false
    var tweetID: Int = -1
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorite (_ isFavorited: Bool){
        didLike = isFavorited
        if (didLike){
            likeButton.setImage(UIImage(named: "redLike"), for: .normal)
        }
        else {
            likeButton.setImage(UIImage(named: "greyLike"), for: .normal)
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        let toBeFavorited = !didLike
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unFavorite(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print ("Unfavorited did not succeed \(error)")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "greenRetweet"), for: .normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "greyRetweet"), for: .normal)
            retweetButton.isEnabled = true
        }
        
    }
    
    @IBAction func retweetButtonPressed(_ sender: UIButton) {
        
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print ("There was an error retweeting: \(error)")
        })
        
        
    }
    
}
