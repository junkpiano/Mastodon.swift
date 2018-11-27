//
//  Account.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/27.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

class Account: Codable {
    let id: String
    let username: String
    let acct: String
    let display_name: String
    let avatar: String
    let avatar_static: String
    let header: String
    let header_static: String
    let emojis: [Emoji]
}
