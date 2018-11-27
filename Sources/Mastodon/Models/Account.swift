//
//  Account.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/27.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

public class Account: Codable {
    public let id: String
    public let username: String
    public let acct: String
    public let display_name: String
    public let avatar: String
    public let avatar_static: String
    public let header: String
    public let header_static: String
    public let emojis: [Emoji]
}
