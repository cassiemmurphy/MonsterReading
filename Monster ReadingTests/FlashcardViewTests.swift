//
//  CardViewTests.swift
//  Monster ReadingTests
//
//  Created by Murphy, Cassie on 6/11/22.
//

import XCTest
@testable import Monster_Reading
import ViewInspector

extension FlashcardView: Inspectable {}

class FlashcardViewTests: XCTestCase {
   func testCardView() throws {
      let cardView = FlashcardView(word: WordManager(word: "word", definition: "this is the definition"))
      
      XCTAssertNotNil(cardView)
      
      //let textView = try cardView.inspect().find(
   }

}
