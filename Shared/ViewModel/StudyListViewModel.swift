//
//  StudyListViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import Foundation
import Firebase

class StudyListViewModel: ObservableObject {
   @Published var lists = [StudyList]()
   let db = Firestore.firestore()
   
   func getStudyLists() {
      db.collection("StudyLists").getDocuments { snapshot, error in
         // TODO: handle error instead of just escaping
         guard let snapshot = snapshot, error == nil  else { return }

         DispatchQueue.main.async {
            self.lists = snapshot.documents.compactMap({ queryDocumentSnapshot -> StudyList? in
               return try? queryDocumentSnapshot.data(as: StudyList.self)
            })
         }
      }
   }
   
   
   
   private func getWordData(docID: String) -> [VocabWord] {
      var words = [VocabWord]()
      db.collection("studylists").getDocuments { snapshot, error in
         if let error = error {
            print("Error getting study words. \(error)")
            return
         }
         guard let snapshot = snapshot else { return }
         
         DispatchQueue.main.async {
            words = snapshot.documents.compactMap { queryDocumentSnapshot -> VocabWord? in
               return try? queryDocumentSnapshot.data(as: VocabWord.self)
            }
         }
      }

      return words
   }
   
}

