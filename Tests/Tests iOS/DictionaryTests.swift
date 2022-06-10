//
//  DictionaryTests.swift
//  Tests iOS
//
//  Created by Murphy, Cassie on 6/9/22.
//

import XCTest
@testable import Monster_Reading

class DictionaryTests: XCTestCase {
   var sut: DictionaryConnection!

    override func setUpWithError() throws {
       try super.setUpWithError()
       sut = DictionaryConnection()
    }

    override func tearDownWithError() throws {
       try super.tearDownWithError()
       sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

   func testWordArrayElementMatchesGivenFetchWord() {
      // given
      let word = "bat"
      
      // when
      sut.fetchVocabData(word: word)
      
      // then
      XCTAssertEqual(sut.words.first?.word, "bat")
   }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
