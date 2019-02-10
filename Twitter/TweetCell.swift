//
//  TweetCell.swift
//  Twitter
//
//  Created by Josh Tav on 1/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    @IBAction func favAction(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: { self.setFavorite(true) }, failure: { (error) in
                print("Favorite did not succeed!: \(error) ")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed!: \(error) ")
            })
        }
    }
    
    @IBAction func retweetAction(_ sender: Any) {
        let tobeRetweeted = !retweeted
        if (tobeRetweeted){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweet(true)
            }, failure: { (error) in
                print("Error in retweeting: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unRetweet(tweetId: tweetId, success: {
                self.setRetweet(false)
            }, failure: { (error) in
                print("UnRetweet did not succeed!: \(error)")
            })
        }
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (isFavorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }

    func setRetweet(_ isRetweeted:Bool){
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
