//
//  Headers.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/10/12.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

class Headers {
    var maxId: String
    var minId: String

    init(with data: [AnyHashable: Any]) {
        if let link = data["Link"] as? String {
            let result = Headers.extractMaxMinId(link: link)
            maxId = result.0
            minId = result.1
        } else {
            maxId = ""
            minId = ""
        }
    }
}

extension Headers {
    private static func extractMaxMinId(link: String) -> (String, String) {
        let elements = link.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").split(separator: ",")
        var maxId = ""
        var sinceId = ""

        elements.forEach { (element) in
            let link = element.split(separator: ";")[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let rel = element.split(separator: ";")[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if rel.contains("next"), let url = URL(string: link) {
                if let query = url.query {
                    query.split(separator: "&").forEach({ (param) in
                        let keyValue = param.split(separator: "=")
                        if keyValue[0] == "max_id" {
                            maxId = String(keyValue[1])
                        }
                    })
                }
            }

            if rel.contains("prev"), let url = URL(string: link) {
                if let query = url.query {
                    query.split(separator: "&").forEach({ (param) in
                        let keyValue = param.split(separator: "=")
                        if keyValue[0] == "min_id" {
                            sinceId = String(keyValue[1])
                        }
                    })
                }
            }
        }

        return (maxId, sinceId)
    }
}
