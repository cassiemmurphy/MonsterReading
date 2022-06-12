//
//  DictionaryConnectionTests.swift
//  Monster ReadingTests
//
//  Created by Murphy, Cassie on 6/11/22.
//

import XCTest
@testable import Monster_Reading

class DictionaryConnectionTests: XCTestCase {
   var dictionaryConnection: DictionaryConnection!
   var session: URLSession!
   
    override func setUpWithError() throws {
       try super.setUpWithError()
       dictionaryConnection = DictionaryConnection()
       session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
       dictionaryConnection = nil
       session = nil
       try super.tearDownWithError()
    }
   
   func testWordArrayIsEmpty() {
      // test words starts empty
      XCTAssertTrue(dictionaryConnection.words.isEmpty)
   }
   
   func testWordArrayAppendsWord() {
      // given
      let word = WordManager(word: UUID().uuidString, definition: UUID().uuidString)
      
      // when
      dictionaryConnection.words.append(word)
      
      // then
      XCTAssertNotNil(dictionaryConnection.words)
   }
   
   func testWordArrayAppendsWordsStress() {
      // given
      var word: WordManager
      
      // when
      let loopCount = Int.random(in: 1..<100)
      for _ in 0..<loopCount {
         word = WordManager(word: UUID().uuidString, definition: UUID().uuidString)
         dictionaryConnection.words.append(word)
      }
      
      // then
      XCTAssertNotNil(dictionaryConnection.words)
      XCTAssertTrue(dictionaryConnection.words.count == loopCount)
   }
  
   func testApiCallWithoutAuthenticationFails() throws {
     // given
     let urlString =
       "https://od-api.oxforddictionaries.com/api/v2/entries/en-us/flat"
     let url = URL(string: urlString)!

     // when
     session.dataTask(with: url) { _, response, error in
       // then
       if let error = error {
         XCTFail("Error: \(error.localizedDescription)")
         return
       } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
         if statusCode == 200 {
           XCTFail("Call went through without authentication")
         } else {
           XCTExpectFailure()
         }
       }
     }
   }
   
   func testValidApiCallGetsHTTPStatusCode200() throws {
     // given
      let urlString =
       "https://od-api.oxforddictionaries.com/api/v2/entries/en-us/flat"
      let url = URL(string: urlString)!
      var request = URLRequest(url: url)
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue("f9e70613", forHTTPHeaderField: "app_id")
      request.addValue("3a7c21194f6b52c89b3084afbfd5ad60", forHTTPHeaderField: "app_key")
      let promise = expectation(description: "Status code: 200")

     // when
     let dataTask = session.dataTask(with: request) { _, response, error in
       // then
       if let error = error {
         XCTFail("Error: \(error.localizedDescription)")
         return
       } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
         if statusCode == 200 {
           promise.fulfill()
         } else {
           XCTFail("Status code: \(statusCode)")
         }
       }
     }
     dataTask.resume()

     wait(for: [promise], timeout: 5)
   }

}
