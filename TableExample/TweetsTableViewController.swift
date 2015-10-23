//
//  FruitsTableViewController.swift
//  TableExample
//
//  Created by Ralf Ebert on 27/04/15.
//  Copyright (c) 2015 Example. All rights reserved.
//

import UIKit
import Social
import Accounts


class TweetsTableViewController: UITableViewController, UITextViewDelegate {
    var viewModel: TweetsTableViewModel? = nil
    
    
    @IBAction func addtweet(sender: AnyObject) {
        self.viewModel?.fetchTweets { error, tweets in
            if error == nil {
                print("Fetched tweets \(tweets?.count)")
                self.tableView.reloadData()
            } else {
                print("Errpr fetching tweets")
                // TODO alert®…
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TweetsTableViewModel(twitterService: TwitterService())
        self.addtweet("")
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetTableViewCell
        cell.viewModel = viewModel![indexPath]
        cell.tweetTextView.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("SELECCIONADO!")
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
    
}