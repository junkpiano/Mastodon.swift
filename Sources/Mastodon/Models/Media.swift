//
//  Media.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/30.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

struct Media: Codable {
    let type: String
    let url: String
    let preview_url: String
    let remote_url: String?
}
