//
//  Constants.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/23.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

extension MastodonAPI {
    public static let oauthAuthorizePath = "/oauth/authorize"
    public static let oauthTokenPath = "/oauth/token"
    public static let oauthRedirectPath = "/oauth/authorize/native"
    public static let timelinesHomePath = "/api/v1/timelines/home"
    public static let timelinesPublicPath = "/api/v1/timelines/public"
    public static let timelinesHashtagPath = "/api/v1/timelines/tag/:hashtag"
    public static let statusesPath = "/api/v1/statuses"
    public static let statusesByIdPath = "/api/v1/statuses/:id"
    public static let statusesContextByIdPath = "/api/v1/statuses/:id/context"
    public static let statusesCardByIdPath = "/api/v1/statuses/:id/card"
    public static let statusesRebloggedByByIdPath = "/api/v1/statuses/:id/reblogged_by"
    public static let statusesFavouritedByByIdPath = "/api/v1/statuses/:id/favourited_by"
    public static let customEmojiPath = "/api/v1/custom_emojis"
    public static let accountsPath = "/api/v1/accounts/:id"
}
