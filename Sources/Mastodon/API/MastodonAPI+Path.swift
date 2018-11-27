//
//  Constants.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/23.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

extension MastodonAPI {
    static let oauthAuthorizePath = "/oauth/authorize"
    static let oauthTokenPath = "/oauth/token"
    static let oauthRedirectPath = "/oauth/authorize/native"
    static let timelinesHomePath = "/api/v1/timelines/home"
    static let timelinesPublicPath = "/api/v1/timelines/public"
    static let timelinesHashtagPath = "/api/v1/timelines/tag/:hashtag"
    static let statusesPath = "/api/v1/statuses"
    static let statusesByIdPath = "/api/v1/statuses/:id"
    static let statusesContextByIdPath = "/api/v1/statuses/:id/context"
    static let statusesCardByIdPath = "/api/v1/statuses/:id/card"
    static let statusesRebloggedByByIdPath = "/api/v1/statuses/:id/reblogged_by"
    static let statusesFavouritedByByIdPath = "/api/v1/statuses/:id/favourited_by"
    static let customEmojiPath = "/api/v1/custom_emojis"
    static let accountsPath = "/api/v1/accounts/:id"
}
