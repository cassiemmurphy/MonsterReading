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
   @Published var selectedList: StudyList?
   
   let db = Firestore.firestore()
   
   func getStudyLists(grade: Grade) {
      
      db.collection("studylists").whereField("grade", isEqualTo: grade.rawValue).getDocuments { snapshot, error in
         guard let snapshot = snapshot, error == nil  else { return }

         DispatchQueue.main.async {
            self.lists = snapshot.documents.compactMap({ queryDocumentSnapshot -> StudyList? in
               return try? queryDocumentSnapshot.data(as: StudyList.self)
            })
         }
      }
   }
   /*
    STW Sight Words - Unit 4
    in, you, do, am, ball
    STW Sight Words - Unit 5
    an, for, to, it, girl

    */
   func createLists() {
      let words = [VocabWord(id: "in", definition: "", pronunciation: "", image: ""),
                 VocabWord(id: "you", definition: "", pronunciation: "", image: ""),
                 VocabWord(id: "do", definition: "", pronunciation: "", image: ""),
                 VocabWord(id: "am", definition: "", pronunciation: "", image: ""),
                 VocabWord(id: "ball", definition: "", pronunciation: "", image: "")]
      let list = StudyList(title: "STW Sight Words - Unit 4", grade: .kindergarten, words: words)
      
      do {
         try db.collection("studylists").document().setData(from: list)
      } catch {
         print("Error writing list, \(error)")
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

