//
//  Mastodon.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/25.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Kiri

public class Mastodon {
    public static let shared = Mastodon()

    public var hostname: String = ""
    public var token: String = ""
    public var clientId: String = ""
    public var secretId: String = ""
    public var scope: String = ""
    public var redirectUri: String = ""

    public static func load(hostname: String,
                     token: String = "",
                     clientId: String = "",
                     secretId: String = "",
                     scope: String = "",
                     redirectUri: String = "") {
        self.shared.hostname = hostname
        self.shared.clientId = clientId
        self.shared.secretId = secretId
        self.shared.scope = scope
        self.shared.redirectUri = redirectUri

        if token.count > 0 {
            self.shared.token = token
        }
    }

    public static func fetchTimeline(type: MastodonAPI.TimelineType,
                                     hashTag: String,
                                     listId: String,
                                     maxId: String,
                                     completion: @escaping ([Status]?, Headers?, Error?) -> Void) {
        Kiri<API>(request: .timeline(type, hashTag, listId, maxId)).send { (response, error) in
            
            var headers: Headers?
            
            if let response = response?.response {
                headers = Headers(with: response.allHeaderFields)
            }
            
            do {
                let result: [Status]? = try response?.decodeJSON()
                completion(result, headers, error)
            } catch {
                completion(nil, headers, error)
            }
            
        }
    }
    
    public static func fetchStatus(type: MastodonAPI.StatusesType,
                                   statusId: String,
                                   completion: @escaping (Status?, Error?) -> Void) {
        Kiri<API>(request: .status(type, statusId)).send(completion: { (response, error) in
            do {
                if let response = response, let status: Status = try response.decodeJSON() {
                    completion(status, nil)
                } else {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error)
            }
        })
    }
    
    public static func postToot(tootText: String,
                                mediaIDs: [Int],
                                sensitive: Bool) {
        Kiri<MastodonAPI>(request: .toot(tootText, mediaIDs, sensitive)).send { (response, error) in
            debugPrint(error ?? "no error")
        }
    }
    
    public static func fetchAccount(accountId: String,
                                    completion: @escaping (Account?, Error?) -> Void) {
        Kiri<API>(request: .account(accountId)).send { (response, error) in
            if let response = response {
                do {
                    let account: Account = try response.decodeJSON()
                    completion(account, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
