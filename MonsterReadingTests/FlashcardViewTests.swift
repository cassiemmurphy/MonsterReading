//
//  CardViewTests.swift
//  Monster ReadingTests
//
//  Created by Murphy, Cassie on 6/11/22.
//

import XCTest
@testable import Monster_Reading
import ViewInspector

extension CardView: Inspectable {}

class FlashcardViewTests: XCTestCase {
   func testCardView() throws {
      let cardView = CardView(word: WordViewModel(cdWord: Word()))
      
      XCTAssertNotNil(cardView)
      
      //let textView = try cardView.inspect().find(
   }

}
