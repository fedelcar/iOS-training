//
//  TweetCellViewModel.swift
//  TableExample
//
//  Created by Federico López Cañás on 10/22/15.
//  Copyright © 2015 Example. All rights reserved.
//

import Foundation
import UIKit

public struct TweetCellViewModel {
    
    private let _tweet: Tweet
    
    public init(tweet: Tweet) {
        _tweet = tweet
    }
}

extension TweetCellViewModel {
    public var text: String {
        return _tweet.text
    }
    
    public var time: String {
        let date = _tweet.time
        let tweetTimeAgo = timeAgoSinceDate(date, numericDates: true)
        return  tweetTimeAgo
    }
    
    func formatedString(entities: NSDictionary) -> NSAttributedString {
        let plainText = NSAttributedString(string: _tweet.text)
        let textWithUrls:NSAttributedString = formatFor("urls", elementKey: "url", entities: entities, inputText: plainText)
        let textWithHashtags:NSAttributedString = formatFor("hashtags", elementKey: "text", entities: entities, inputText: textWithUrls)
        
        return textWithHashtags
    }
    
    func formatFor(collectionKey: String, elementKey: String,  entities: NSDictionary, inputText: NSAttributedString) -> NSAttributedString {
        let outputText: NSMutableAttributedString = NSMutableAttributedString(attributedString: inputText)
        if let entityDictionary: [NSDictionary] = entities.objectForKey(collectionKey) as? [NSDictionary]{
            for entity in entityDictionary {
                let searchItem = entity.objectForKey(elementKey) as! String
                let searchIndex = inputText.string.rangeOfString(searchItem)!
                let intIndex: Int = inputText.string.startIndex.distanceTo(searchIndex.startIndex)
                let range = NSMakeRange(intIndex, searchItem.characters.count)
                outputText.addAttribute(NSLinkAttributeName, value: entity, range: range)
            }
        }
        return outputText
    }
}