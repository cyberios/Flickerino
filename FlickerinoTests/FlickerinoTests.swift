//
//  test_taskTests.swift
//  test_taskTests
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import XCTest
@testable import Flickerino

class test_taskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_formatDate() {
        let assertText:String = "14 октября"
        let testText:String = "2020-10-14 20:30:45"
        let formatted = testText.formatDate()
        XCTAssertEqual(assertText, formatted)
    }
    
    func test_formatTags(){
        let assertArray = ["Apple"]
        let testText:String = "Apple Orange Strawberry"
        let formatted = testText.formatTags(offset: 1)

        XCTAssertEqual(assertArray, formatted)
    }
    
    func test_maxLength(){
        let assertStr = "123456789"
        let testText:String = "1234567891011121314"
        let formatted = testText.maxLength(length:9)
        XCTAssertEqual(assertStr, formatted)
    }

}
