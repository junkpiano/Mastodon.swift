//
//  Document.swift
//  TomorrowLand
//
//  Created by Yusuke Ohashi on 2018/09/27.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import Foundation

class Document {
    let source: String
    var documentType: String
    var body: String
    var entities: [Entity] = [Entity]()

    init(source: String) {
        self.source = source
        self.body = ""
        self.documentType = ""
        let scanner = Scanner(string: source)
        self.entities.append(createEntities(from: source, scanner: scanner))
    }

    func text() -> String {
        return self.body
    }

    private func createEntities(from source: String, scanner: Scanner, parent: Entity? = nil) -> Entity {
        let currentEntity: Entity = Entity()

        while !scanner.isAtEnd {
            var tmp: NSString?
             scanner.scanUpTo("<", into: &tmp)
            if let nonNullTmp = tmp, nonNullTmp.length > 0 {
                self.body.append(String(nonNullTmp))
                currentEntity.body.append(String(nonNullTmp))
                parent?.body.append(String(nonNullTmp))
            }

            if !scanner.isAtEnd {
                tmp = nil
                scanner.scanUpTo(">", into: &tmp)

                if let nonNullTmp = tmp {
                    if nonNullTmp.hasPrefix("<!") {
                        documentType = String(nonNullTmp)
                    } else if nonNullTmp.hasPrefix("</") {
                        if currentEntity.open {
                            currentEntity.open = false
                            scanner.scanLocation = scanner.scanLocation + 1
                            if !scanner.isAtEnd {
                                if let p = parent {
                                    p.entities.append(currentEntity)
                                }
                            }
                        }
                    } else {
                        let tempStr = String(nonNullTmp)
                        let attrs = tempStr.split(separator: " ")

                        if tempStr.hasPrefix("</p"), scanner.scanLocation + 1 != source.count {
                            self.body.append("\n\n")
                        }

                        if currentEntity.open, currentEntity.name.count > 0 {
                            scanner.scanLocation = scanner.scanLocation + 1
                            currentEntity.entities.append(createEntities(from: source, scanner: scanner, parent: currentEntity))
                        } else {
                            currentEntity.name = String(attrs.first ?? "").replacingOccurrences(of: "<", with: "")
                            currentEntity.attrs = [:]
                            if currentEntity.name.hasPrefix("<br") {
                                self.body.append("\n")
                                currentEntity.open = false
                            } else {
                                currentEntity.open = true
                            }

                            if let p = parent {
                                p.entities.append(currentEntity)
                            }
                        }
                    }
                }

                if !scanner.isAtEnd {
                    scanner.scanLocation = scanner.scanLocation + 1
                }
            }
        }

        return currentEntity
    }
}
