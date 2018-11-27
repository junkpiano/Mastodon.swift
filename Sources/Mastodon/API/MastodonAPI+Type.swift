//
//  APITypes.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/11/08.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation
import Kiri

extension MastodonAPI {
    enum StatusesType {
        case status, context, card
        
        func statusPath(_ id: String) -> String {
            var statusPath = ""
            switch self {
            case .status:
                statusPath = MastodonAPI.statusesByIdPath
            case .context:
                statusPath = MastodonAPI.statusesContextByIdPath
            case .card:
                statusPath = MastodonAPI.statusesCardByIdPath
            }
            return statusPath.replacingOccurrences(of: ":id", with: id)
        }
    }
    
    enum TimelineType {
        case home, local, federation, hashtag
        
        func timelinePath(_ hashTag: String) -> String {
            switch self {
            case .home:
                return MastodonAPI.timelinesHomePath
            case .local:
                return MastodonAPI.timelinesPublicPath
            case .federation:
                return MastodonAPI.timelinesPublicPath
            case .hashtag:
                return MastodonAPI.timelinesHashtagPath.replacingOccurrences(of: ":hashtag", with: hashTag.urlEncoded())
            }
        }
        
        func timelineParameters() -> Parameters {
            switch self {
            case .local:
                return ["local": "true"]
            default:
                return [:]
            }
        }
    }
}
