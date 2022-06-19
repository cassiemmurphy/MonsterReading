//
//  WordViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/16/22.
//

import Foundation
import CoreData

struct WordViewModel {
   let cdWord: Word
   
   // FIXME: Do I need this?
   var id: NSManagedObjectID {
      return cdWord.objectID
   }
   
   var word: String {
      return cdWord.id ?? ""
   }
   
   var definition: String {
      return cdWord.definition ?? ""
   }
   
   var pronunciation: String {
      return cdWord.pronunciation ?? ""
   }
   
   var phoneticSpelling: String {
      return cdWord.phoneticSpelling ?? ""
   }
   
   var image: String {
      return cdWord.image ?? ""
   }
}
