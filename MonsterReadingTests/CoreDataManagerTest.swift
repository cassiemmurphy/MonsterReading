//
//  CoreDataManagerTest.swift
//  Monster Reading Tests
//
//  Created by Murphy, Cassie on 6/12/22.
//

import XCTest
import CoreData
@testable import Monster_Reading

//class TestCoreDataManager: CoreDataManager {
//  override init() {
//    super.init()
//
//    // 1
//    let persistentStoreDescription = NSPersistentStoreDescription()
//    persistentStoreDescription.type = NSInMemoryStoreType
//
//    // 2
//    let container = NSPersistentContainer(
//      name: "Vocabulary",
//      managedObjectModel: Word)
//
//    // 3
//    container.persistentStoreDescriptions = [persistentStoreDescription]
//
//    container.loadPersistentStores { _, error in
//      if let error = error as NSError? {
//        fatalError("Unresolved error \(error), \(error.userInfo)")
//      }
//    }
//
//    // 4
//    storeContainer = container
//  }
//}


class CoreDataManagerTest: XCTestCase {
   var coreDM: CoreDataManager!

    override func setUpWithError() throws {
       try super.setUpWithError()
       let coreDM = CoreDataManager.shared
    }

    override func tearDownWithError() throws {
       coreDM = nil
       try super.tearDownWithError()
    }

   func testAddWordCoreDataWithAllData() {
      // given
      let word = "blue"
      let definition = "the color of the sky"
      
      // when
     //coreDM.saveWord()
      
      // then
      
   }
   
   func testSaveWithoutRequiredDataFails() {
      // given
      
      // when
      
      // then
      
   }
   
   func testGetAllWordsReturnsArray() {
      // given
      
      // when
      
      // then
      
   }
   
   func testRemoveExistingWord() {
      // given
      
      // when
      
      // then
      
   }
   
   func testRemoveNonExistingWord() {
      // given
      
      // when
      
      // then
      
   }
   

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
