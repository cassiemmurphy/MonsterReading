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
      db.collection("studylists").whereField("grade", isEqualTo: grade.rawValue)
          .getDocuments() { (snapshot, error) in
              if let error = error {
                  print("Error getting documents: \(error)")
              } else {
                 guard let snapshot = snapshot else { return }
                  for document in snapshot.documents {
                     self.lists = snapshot.documents.compactMap({ queryDocumentSnapshot -> StudyList? in
                        return try? queryDocumentSnapshot.data(as: StudyList.self)
                     })
                  }
              }
      }
   }
   
   
   /*
    STW Sight Words - Unit 2
    is, this, my, me, dog
    STW Sight Words - Unit 3
    we, like, and, at, pig
    STW Sight Words - Unit 4
    in, you, do, am, ball
    STW Sight Words - Unit 5
    an, for, to, it, girl
    STW Sight Words - Unit 6
    has, him, are, her, boy
    STW Sight Words - Unit 7
    no, go, yes, so, bug
    STW Sight Words - Unit 8
    that, said, them, eat, egg
    STW Sight Words - Unit 9
    on, will, off, of, cup
    STW Sight Words - Unit 10
    here, say, out, up, mom
    STW Sight Words - Unit 11
    she, he, saw, they, dad
    STW Sight Words - Unit 12
    big, why, can, have, fish
    STW Sight Words - Unit 13
    with, but, not, had, toy
    STW Sight Words - Unit 14
    four, two, one, three, door

    */
   func createLists() {
      let words = [VocabWord(id: "the", pronunciation: "https://audio.oxforddictionaries.com/en/mp3/the__us_1.mp3", points: 10),
                   VocabWord(id: "I", pronunciation: "https://audio.oxforddictionaries.com/en/mp3/_ae_1_us_1.mp3", points: 5),
                   VocabWord(id: "see", pronunciation: "https://audio.oxforddictionaries.com/en/mp3/_sy_1_us_1.mp3", points: 5),
                   VocabWord(id: "a", pronunciation: "https://audio.oxforddictionaries.com/en/mp3/_ae_1_us_2.mp3", points: 5),
                   VocabWord(id: "cat", pronunciation: "https://audio.oxforddictionaries.com/en/mp3/cat__us_1.mp3", points:5)]
      let list = StudyList(title: "Unit 1", grade: .kindergarten, words: words, category: .sight)

      do {
         try db.collection("studylists").document().setData(from: list)
      } catch {
         print("Error writing list, \(error)")
      }
   }
   
   func addListToChild(user: FirebaseAuth.User, child: Child, list: StudyList) {
      var listRef: DocumentReference!
      
      guard let id = child.id, let listID = list.id else { return }
      
      let documentRefString = db.collection("studylists").document(listID)
      listRef = db.document("studylists/\(documentRefString)")
      
      
      db.collection("users/\(user.uid)/children").document(id).updateData([
         "studyLists" : FieldValue.arrayUnion([listRef])
      ]) { error in
         if let error = error {
            print(error.localizedDescription)
         } else {
            print("Studylist successfully added.")
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

