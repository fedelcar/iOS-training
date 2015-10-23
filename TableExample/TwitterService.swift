//
//  TwitterService.swift
//  TableExample
//
//  Created by Federico López Cañás on 10/20/15.
//  Copyright © 2015 Example. All rights reserved.
//

import Foundation
import Social
import Accounts

protocol TwitterServiceType {
    
    func fetchTimeline(twitterHandle: String, callback:(NSError?, [Tweet]?) -> ())

}

public struct TwitterService: TwitterServiceType {

    func fetchTimeline(twitterHandle: String, callback:(NSError?, [Tweet]?) -> ()) {
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(
            ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil) { success, error in
            if error != nil {
                callback(error, nil)
            } else {
                let accounts = account.accountsWithAccountType(accountType)
                let twitterAccount = accounts.last as! ACAccount
                self.fetch(twitterAccount, forUser: twitterHandle, callback: callback)
            }
        }
    }
    
    private func fetch(account: ACAccount, forUser twitterHandle: String, callback:(NSError?, [Tweet]?) -> ()) {
        let requestURL = NSURL(string:
            "https://api.twitter.com/1.1/statuses/user_timeline.json")
        
        let parameters = ["screen_name" : twitterHandle,
            "include_rts" : "0",
            "trim_user" : "0",
            "count" : "30"]
        
        let postRequest = SLRequest(forServiceType:
            SLServiceTypeTwitter,
            requestMethod: SLRequestMethod.GET,
            URL: requestURL,
            parameters: parameters)
        
        postRequest.account = account
        postRequest.performRequestWithHandler { self.parseResponse($0, error: $2, callback: callback) }
        
    }
    
    private func parseResponse(data: NSData, error: NSError!, callback:(NSError?, [Tweet]?) -> ()) {
        if error != nil {
            callback(error, nil)
        } else {
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves) as! [NSDictionary]
                callback(nil, result.map { deserializeTweet($0) })
            } catch let error as NSError {
                callback(error, nil)
            }
            
        }
    }
    
}