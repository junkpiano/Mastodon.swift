//
//  String+Mastodon.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/23.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

extension String {
    func urlEncoded() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }

    func stripHTML() -> (String, [String: String]) {
        var result: String = ""
        var hyperLinks: [String: String] = [:]

        let scanner = Scanner(string: self)
        scanner.charactersToBeSkipped = nil

        var linkurl = ""
        var linktext = ""

        while !scanner.isAtEnd {
            var tmp: NSString? = ""
            scanner.scanUpTo("<", into: &tmp)
            if let nonNullTmp = tmp {
                result.append(String(nonNullTmp))
                if linkurl.count > 0 {
                    linktext.append(nonNullTmp as String)
                }
            }

            if !scanner.isAtEnd {
                scanner.scanUpTo(">", into: &tmp)

                if let nonNullTmp = tmp {
                    if nonNullTmp == "<br" {
                        result.append("\n")
                    } else if nonNullTmp == "</p", scanner.scanLocation + 1 != self.count {
                        result.append("\n\n")
                    } else if nonNullTmp.hasPrefix("<a ") {
                        var attrs: [String: String] = [:]
                        String(nonNullTmp).split(separator: " ").forEach { (attr) in
                            var keyValue = attr.split(separator: "=")
                            if keyValue.count > 1 {
                                attrs[String(keyValue[0])] = String(keyValue[1])
                            }
                        }
                        linkurl = attrs["href"] ?? ""
                    } else if nonNullTmp.hasPrefix("</a") {
                        if linkurl.count > 0, linktext.count > 0 {
                            hyperLinks[linktext] = linkurl
                        }
                        linkurl = ""
                        linktext = ""
                        }
                }

                if !scanner.isAtEnd {
                    scanner.scanLocation = scanner.scanLocation + 1
                }
            }
        }

        if result.hasSuffix("\n\n") {
            result = String(result.dropLast(2))
        }

        result = result.replacingOccurrences(of: "&apos;", with: "'")
        result = result.replacingOccurrences(of: "&amp;", with: "&")
        result = result.replacingOccurrences(of: "&gt;", with: ">")
        result = result.replacingOccurrences(of: "&lt;", with: "<")

        return (result, hyperLinks)
    }
}
