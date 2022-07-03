//
//  StudyListViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import Foundation
import Firebase

class StudyListViewModel: ObservableObject {
   
   enum PopupState {
      case none
      case present
      case dismiss
      
      var isPresented: Bool { self == .present }
   }
   
   @Published private(set) var popupState: PopupState = .none
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
   
   func present() {
      guard !popupState.isPresented else { return }
      self.popupState = .present
   }
   
   func dismiss() {
      self.popupState = .dismiss
   }
}

