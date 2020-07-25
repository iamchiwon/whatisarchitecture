//
//  AsyncUtil.swift
//  MyToDoTests
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import XCTest

extension XCTestCase {
    func async(timeout: TimeInterval = 10,
               title: String = #function,
               job: @escaping (@escaping () -> Void) -> Void) {
        let expectation = self.expectation(description: title)

        job {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
}
