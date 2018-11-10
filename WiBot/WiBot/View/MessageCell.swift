//
//  MessageCell.swift
//  WiBot
//
//  Created by Ian Carvalho on 09/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var owner: MessageOwner = .User {
        didSet {
            switch owner {
            case .User:
                leadingConstraint.priority = UILayoutPriority(rawValue: 749)
                trailingConstraint.priority = UILayoutPriority(rawValue: 750)
            case .Bot:
                leadingConstraint.priority = UILayoutPriority(rawValue: 750)
                trailingConstraint.priority = UILayoutPriority(rawValue: 749)
            }
        }
    }
}
