//
//  Word.swift
//
//  Created by Murphy, Cassie on 6/8/22.
//

import Foundation
import SwiftUI

struct WordManager: Decodable, Hashable {
   let word: String
   var pronunciation: String?
   
   private enum CodingKeys: String, CodingKey {
      case word, results
      
      enum Results: String, CodingKey {
         case lexicalEntries
         
         enum LexicalEntries: String, CodingKey {
            case entries, phrases
            
            enum Entries: String, CodingKey {
               case pronunciations
               enum Pronunciation: String, CodingKey {
                  case pronunciation = "audioFile"
               }
            }
         }
      }
   }
   
   init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      word = try container.decode(String.self, forKey: .word)
      
      var resultContainer = try container.nestedUnkeyedContainer(forKey: .results)
      let firstResultContainer = try resultContainer.nestedContainer(keyedBy: CodingKeys.Results.self)
      
      var lexicalEntryContainer = try firstResultContainer.nestedUnkeyedContainer(forKey: .lexicalEntries)
      let firstLexicalEntryContainer = try lexicalEntryContainer.nestedContainer(keyedBy: CodingKeys.Results.LexicalEntries.self)
      
      var entryContainer = try firstLexicalEntryContainer.nestedUnkeyedContainer(forKey: .entries)
      let firstEntryContainer = try entryContainer.nestedContainer(keyedBy: CodingKeys.Results.LexicalEntries.Entries.self)
      
      var pronunciationContainer = try firstEntryContainer.nestedUnkeyedContainer(forKey: .pronunciations)
      while !pronunciationContainer.isAtEnd {
         let nestedPronunciationContainer = try pronunciationContainer.nestedContainer(keyedBy: CodingKeys.Results.LexicalEntries.Entries.Pronunciation.self)
         if let pronunciation = try? nestedPronunciationContainer.decode(String.self, forKey: .pronunciation) {
            self.pronunciation = pronunciation
            break
         }
         
      }
   }
}
