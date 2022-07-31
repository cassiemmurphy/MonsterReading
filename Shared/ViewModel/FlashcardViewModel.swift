//
//  FlashcardViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/16/22.
//

import Foundation
import CoreData

class FlashcardViewModel: ObservableObject {
   
   @Published var words = [VocabWord]()
   
   func getFlashcardWords(child: Child) {
      for list in child.studyLists {
         words.append(contentsOf: list.words)
      }
   }
   
}


