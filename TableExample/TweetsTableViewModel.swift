//
//  TweetsTableViewModel.swift
//  TableExample
//
//  Created by Federico López Cañás on 10/22/15.
//  Copyright © 2015 Example. All rights reserved.
//

import Foundation
import UIKit

public final class TweetsTableViewModel {
    
    private let _twitterService: TwitterService
    private var _tweetList = [TweetCellViewModel]()
    
    public init(twitterService: TwitterService) {
        _twitterService = twitterService
    }
    
    func fetchTweets(callback:(NSError?, [TweetCellViewModel]?) -> ()) -> () {
        _twitterService.fetchTimeline("@fedelcar") { [unowned self] error, tweets in
            if error != nil {
                // alert
            } else {
                self._tweetList = tweets!.map { TweetCellViewModel(tweet: $0) }
                dispatch_async(dispatch_get_main_queue()) {
                    callback(nil, self._tweetList)
                }
            }
        }
    }
    
    subscript(indexPath: NSIndexPath) -> TweetCellViewModel {
        return _tweetList[indexPath.row]
    }

}

extension TweetsTableViewModel {
    
    public var rows: Int {
        return _tweetList.count
    }
    
}
