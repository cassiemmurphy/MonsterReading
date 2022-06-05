//
//  Card.swift
//  Reading Flashcards
//
//  Created by Murphy, Cassie on 5/29/22.
//

import Foundation
import SwiftUI

struct Card: Hashable, Codable {
   let word: String
   let pronunciation: String
//   let image = Image(systemName: "photo")
   
   static let example = Card(word: "Question", pronunciation: "Answer")
}
