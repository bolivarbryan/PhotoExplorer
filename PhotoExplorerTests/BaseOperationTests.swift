//
//  BaseOperationTests.swift
//  PhotoExplorerTests
//
//  Created by Bryan A Bolivar M on 1/05/24.
//  Copyright © 2024 Bolivarbryan. All rights reserved.
//

import Foundation
@testable import PhotoExplorer
import XCTest

class BaseOperationTests: XCTestCase {

    // Test isAsynchronous property
    func testIsAsynchronous() {
        let operation = BaseOperation()
        XCTAssertTrue(operation.isAsynchronous, "isAsynchronous should be true")
    }
}
