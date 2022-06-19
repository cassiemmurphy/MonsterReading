//
//  CoreDataManager.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/11/22.
//

import Foundation
import CoreData

class CoreDataManager {
   let persistenceContainer: NSPersistentContainer
   
   static let shared = CoreDataManager()
   
   private init() {
      persistenceContainer = NSPersistentContainer.init(name: "Vocabulary")
      persistenceContainer.loadPersistentStores{ (description, error) in
         if let error = error {
            fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
         }
      }
   }
   
   func getAllWords() -> [Word] {
      let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
      
      do {
         return try persistenceContainer.viewContext.fetch(fetchRequest)
      } catch {
         print("Failed to fetch words \(error)")
         return []
      }
   }
   
   // FIXME: Do I need the ability to remove a word??
   func removeWord(word: Word) {
      persistenceContainer.viewContext.delete(word)
      
      do {
         try persistenceContainer.viewContext.save()
      } catch {
         persistenceContainer.viewContext.rollback()
         print("Failed to remove word \(error)")
      }
   }
   
   func saveWord() {
      do {
         try persistenceContainer.viewContext.save()
      } catch {
         print("Failed to save \(error)")
      }
   }
   
   
}
