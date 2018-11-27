//
//  File.swift
//  MastodonTests
//
//  Created by Yusuke Ohashi on 2018/11/27.
//  Copyright © 2018 Yusuke Ohashi. All rights reserved.
//

import XCTest

import MastodonTests

var tests = [XCTestCaseEntry]()
tests += MastodonSampleTests.allTests()
XCTMain(tests)
