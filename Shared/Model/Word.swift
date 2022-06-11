//
//  Word.swift
//
//  Created by Murphy, Cassie on 6/8/22.
//

import Foundation
import SwiftUI

struct Word: Decodable {
   let word, definition: String
   var pronunciation, phoneticSpelling: String?
   var image: Image?
   
   private enum CodingKeys: String, CodingKey {
      case word, results
      
      enum Results: String, CodingKey {
         case lexicalEntries
         
         enum LexicalEntries: String, CodingKey {
            case entries, phrases
            
            enum Entries: String, CodingKey {
               case senses, pronunciations
               
               enum Senses: String, CodingKey {
                  case definitions
               }
               enum Pronunciation: String, CodingKey {
                  case phoneticSpelling, pronunciation = "audioFile"
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
      
      var senseContainer = try firstEntryContainer.nestedUnkeyedContainer(forKey: .senses)
      let firstSenseContainer = try senseContainer.nestedContainer(keyedBy: CodingKeys.Results.LexicalEntries.Entries.Senses.self)
      let definitions = try firstSenseContainer.decode([String].self, forKey: .definitions)
      definition = definitions.first ?? "No valid definition"
      
      
      var pronunciationContainer = try firstEntryContainer.nestedUnkeyedContainer(forKey: .pronunciations)
      while !pronunciationContainer.isAtEnd {
         let nestedPronunciationContainer = try pronunciationContainer.nestedContainer(keyedBy: CodingKeys.Results.LexicalEntries.Entries.Pronunciation.self)
         if let pronunciation = try? nestedPronunciationContainer.decode(String.self, forKey: .pronunciation) {
            self.pronunciation = pronunciation
            phoneticSpelling = try nestedPronunciationContainer.decode(String.self, forKey: .phoneticSpelling)
            break
         }
         
      }
   }
   
   
   init(word: String, definition: String) {
      self.word = word
      self.definition = definition
   }
   
}
