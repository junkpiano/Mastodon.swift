//
//  Media.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/30.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

public struct Media: Codable {
    public let type: String
    public let url: String
    public let preview_url: String
    public let remote_url: String?
}
