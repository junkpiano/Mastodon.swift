//
//  MastodonAPI.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/11/06.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation
import Kiri

enum MastodonAPI {
    case timeline(TimelineType, String, String, String)
    case token(String)
    case account(String)
    case emoji
    case status(StatusesType, String)
    case toot(String, [Int], Bool)
}

typealias API = MastodonAPI
