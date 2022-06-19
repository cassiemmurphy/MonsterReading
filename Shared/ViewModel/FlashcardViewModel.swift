//
//  FlashcardViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/16/22.
//

import Foundation
import CoreData

class FlashcardViewModel: ObservableObject {
   
   @Published var words = [WordViewModel]()
   
   func addStudyList(studyList: [String]) {
      let dictionaryConnect = DictionaryConnection()
      for word in studyList {
         dictionaryConnect.fetchVocabData(word: word)
      }
   }
   
   func getStudyWords() {
      let words = CoreDataManager.shared.getAllWords()
      DispatchQueue.main.async {
         self.words = words.map(WordViewModel.init)
      }
   }
   
}


