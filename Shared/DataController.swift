//
//  DataController.swift
//  Reading Flashcards
//
//  Created by Murphy, Cassie on 6/4/22.
//
import CoreData
import Foundation

class DataController: ObservableObject{
   let container = NSPersistentContainer(name: "Flashcards")
   
   init() {
      container.loadPersistentStores { description, error in
         if let error = error {
            print("Core Data failed to load: \(error.localizedDescription)")
         }
      }
   }
}
