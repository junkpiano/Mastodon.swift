//
//  Status.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/27.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

class Status: Codable {
    let content: String
    let hyperLinks: [String: String]
    let account: Account
    let reblog: Status?
    let id: String
    let media_attachments: [Media]
    let emojis: [Emoji]
    let mentions: [Mention]

//    let id: String
//    let in_reply_to_id: String?
//    let in_reply_to_account_id: String?
//    let sensitive: Bool
//    let url: String?
//    let visibility: String
//    let replies_count: Int
//    let reblogs_count: Int
//    let favourites_count: Int

    enum CodingKeys: String, CodingKey {
        case content
        case account
        case reblog
        case id
        case media_attachments
        case emojis
        case mentions
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tmp = try values.decode(String.self, forKey: .content)
        (content, hyperLinks) = tmp.stripHTML()
        account = try values.decode(Account.self, forKey: .account)
        reblog = try values.decodeIfPresent(Status.self, forKey: .reblog)
        media_attachments = try values.decode([Media].self, forKey: .media_attachments)
        id = try values.decode(String.self, forKey: .id)
        emojis = try values.decode([Emoji].self, forKey: .emojis)
        mentions = try values.decode([Mention].self, forKey: .mentions)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(account, forKey: .account)
        try container.encodeIfPresent(reblog, forKey: .reblog)
        try container.encode(media_attachments, forKey: .media_attachments)
        try container.encode(id, forKey: .id)
        try container.encode(emojis, forKey: .emojis)
        try container.encode(mentions, forKey: .mentions)
    }

    func mention(by username: String) -> Mention? {
        return mentions.filter { (mention) -> Bool in
            mention.username == username
        }.first
    }
}
