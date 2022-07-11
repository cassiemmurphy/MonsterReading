//
//  StudyListTests.swift
//  Monster Reading Tests
//
//  Created by Murphy, Cassie on 7/10/22.
//

import XCTest
@testable import Monster_Reading

class StudyListTests: XCTestCase {
   var studyList: StudyListViewModel!

    override func setUpWithError() throws {
       try super.setUpWithError()
       studyList = StudyListViewModel()
    }

    override func tearDownWithError() throws {
       studyList = nil
       try super.tearDownWithError()
    }

    func testGetList() throws {
       
    }
   func testGetListFail() throws {
      
   }
   func testPresent() throws {
      
   }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
