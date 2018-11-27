//
//  Status.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/27.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

public class Status: Codable {
    public let content: String
    public let hyperLinks: [String: String]
    public let account: Account
    public let reblog: Status?
    public let id: String
    public let media_attachments: [Media]
    public let emojis: [Emoji]
    public let mentions: [Mention]

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

    required public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(account, forKey: .account)
        try container.encodeIfPresent(reblog, forKey: .reblog)
        try container.encode(media_attachments, forKey: .media_attachments)
        try container.encode(id, forKey: .id)
        try container.encode(emojis, forKey: .emojis)
        try container.encode(mentions, forKey: .mentions)
    }

    public func mention(by username: String) -> Mention? {
        return mentions.filter { (mention) -> Bool in
            mention.username == username
        }.first
    }
}
