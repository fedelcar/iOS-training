//
//  TweetTableViewCell.swift
//  TableExample
//
//  Created by Federico López Cañás on 10/22/15.
//  Copyright © 2015 Example. All rights reserved.
//

import Foundation
import UIKit

public class TweetTableViewCell: UITableViewCell {
    

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var createAtLabel: UILabel!
    
    public var viewModel: TweetCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                bindViewModel(viewModel)
            }
        }
    }
    
    private func bindViewModel(viewModel: TweetCellViewModel) {
        createAtLabel.text = viewModel.time
        createAtLabel?.numberOfLines = 0
        tweetTextView.text = viewModel.text
    }
}
