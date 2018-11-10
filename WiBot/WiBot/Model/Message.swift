//
//  Message.swift
//  WiBot
//
//  Created by Ian Carvalho on 09/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation
import UIKit

enum MessageType {
    case TextMessage(text: String)
    case ImgMessage(img: UIImage)
}

enum MessageOwner {
    case User
    case Bot
}

struct Message {
    var type: MessageType
    var owner: MessageOwner
}
