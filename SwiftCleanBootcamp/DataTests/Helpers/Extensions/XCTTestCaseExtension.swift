//
//  XCTTestCaseExtension.swift
//  DataTests
//
//  Created by Willian Guedes on 22/10/22.
//

import Foundation
import XCTest

extension XCTestCase {
    
    // TIP: Memory Leak
    /// It's import to have a test for memory leak, once it prevents the code isn't overload. If you have this problem, make that leak weak. For example: [weak self] or weak let variableName.
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
