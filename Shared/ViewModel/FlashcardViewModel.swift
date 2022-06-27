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
   
   static var sampleWord: WordViewModel {
      let manager = CoreDataManager.shared
      let word = Word(context: manager.persistenceContainer.viewContext)
      word.id = "hat"
      word.learned = false
      word.definition = "a covering for the head worn for warmth, as a fashion item, or as part of a uniform"
      word.pronunciation = "https://audio.oxforddictionaries.com/en/mp3/hat__us_2.mp3"
      return WordViewModel(cdWord: word)
   }

   
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


