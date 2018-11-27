//
//  MastodonAPI+RequestContainer.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/11/08.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation
import Kiri

extension MastodonAPI: RequestContainer {
    
    var endpoint: URL {
        return URL(string: "https://" + Mastodon.shared.hostname)!
    }
    
    var mockResponse: Response? {
        return nil
    }
    
    var path: String {
        switch self {
        case .timeline(let type, let hashTag, _, _):
            return type.timelinePath(hashTag)
        case .status(let type, let id):
            return type.statusPath(id)
        case .toot:
            return MastodonAPI.statusesPath
        case .account(let accountId):
            return MastodonAPI.accountsPath.replacingOccurrences(of: ":id", with: accountId.urlEncoded())
        case .emoji:
            return MastodonAPI.customEmojiPath
        case .token:
            return MastodonAPI.oauthTokenPath
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .token, .toot:
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        let authHeader = [
            "Authorization": "Bearer \(Mastodon.shared.token)"
        ]
        
        switch self {
        case .timeline(let type, _, _, _):
            if type == .home {
                return authHeader
            }
            
            return [:]
        case .toot:
            return authHeader
        default:
            return [:]
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .timeline(let type, _, _, let maxId):
            var params = type.timelineParameters()
            params["max_id"] = maxId
            return params
        case .token(let code):
            return [
                "code": code,
                "client_id": Mastodon.shared.clientId,
                "client_secret": Mastodon.shared.secretId,
                "redirect_uri": Mastodon.shared.redirectUri,
                "grant_type": "authorization_code"
            ]
        case .toot(let text, let ids, let sensitive):
            return [
                "status": text,
                "media_ids": ids,
                "sensitive": sensitive
            ]
        default:
            return nil
        }
    }
    
    var encoding: URLEncoding {
        switch self {
        case .token:
            return .httpBody
        default:
            return .queryString
        }
    }
    
}
