//
//  StudyListViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import Foundation
import Firebase

class StudyListViewModel: ObservableObject {
   @Published var list = [StudyList]()
   
   func getData() {
      let db = Firestore.firestore()

      db.collection("StudyLists").getDocuments { snapshot, error in
         // TODO: handle error instead of just escaping
         guard let snapshot = snapshot, error == nil  else { return }

         DispatchQueue.main.async {
            self.list = snapshot.documents.compactMap({ queryDocumentSnapshot -> StudyList? in
               return try? queryDocumentSnapshot.data(as: StudyList.self)
            })
         }
      }
   }
   
}

