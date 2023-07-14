//
//  XCTestCase+Helpers.swift
//  CowryTestTests
//
//  Created by ADMIN on 7/14/23.
//

import XCTest
import CowryTest

struct Helper {
    
    static func trackForMemoryLeaks(_ instance: AnyObject, testCase: XCTestCase, file: StaticString = #filePath, line: UInt = #line) {
        testCase.addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    static func makeMainSUT(testCase: XCTestCase, file: StaticString = #filePath, line: UInt = #line) -> (sut: HomeViewModel, fetchRate: FetchRateUsecaseSpy) {
        let fetchRate = FetchRateUsecaseSpy()
        
        let sut = HOmeView
        
        
        trackForMemoryLeaks(fetchRate, testCase: testCase, file: file, line: line)
        return (sut, fetchRate)
    }

}
