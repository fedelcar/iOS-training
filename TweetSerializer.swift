//
//  TweetSerializer.swift
//  TableExample
//
//  Created by Federico López Cañás on 10/20/15.
//  Copyright © 2015 Example. All rights reserved.
//

import Foundation

func deserializeTweet(JSON: NSDictionary) -> Tweet {
    let tweetText = JSON["text"] as! String
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
    let tweetTime:NSDate = dateFormatter.dateFromString(JSON["created_at"] as! String)!
    let tweetEntities = JSON["entities"] as! NSDictionary
    return Tweet(text: tweetText, time: tweetTime, entities: tweetEntities)
}
