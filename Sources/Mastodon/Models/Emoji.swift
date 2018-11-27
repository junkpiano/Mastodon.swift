//
//  Emoji.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/10/12.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

class Emoji: Codable {
    let shortcode: String
    let static_url: String
    let url: String
    let visible_in_picker: Bool
}
