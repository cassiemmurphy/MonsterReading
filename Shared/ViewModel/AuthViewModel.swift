//
//  AuthViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/4/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
   @Published var userSeission: FirebaseAuth.User?
   @Published var childUser: Child?
   @Published var children = [Child]()
   @Published var successfulLogin = false
   
   let db = Firestore.firestore()
   
   init() {
      self.userSeission = Auth.auth().currentUser
      getChildren()
   }
   
   func login(email: String, password: String) {
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
         if let error = error {
            print("Failed to login with error \(error.localizedDescription)")
            self.successfulLogin = false
         }
         
         guard let user = result?.user else { return }
         self.successfulLogin = true
         self.userSeission = user
         self.getChildren()
      }
   }
   
   func register(name: String, email: String, password: String, children: [Child]) {
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
         if let error = error {
            print("Failed to register with error \(error.localizedDescription)")
            return
         }
         guard let user = result?.user else { return }
         self.userSeission = user
         
         let data = ["email": email,
                     "name": name,
                     "uid": user.uid]
         Firestore.firestore().collection("users")
            .document(user.uid)
            .setData(data) { _ in
               print("User created")
            }
         
         for child in children {
            self.addChild(child: child)
         }
         self.getChildren()
      }
   }
   
   func addChild(child: Child) {
      guard let user = userSeission else { return }
      
      let data = ["name": child.name,
                  "grade": child.grade.rawValue,
                  "monster": child.monster]
      
      Firestore.firestore().collection("users/\(user.uid)/children")
         .document()
         .setData(data) { _ in
            print("child created")
         }
      
   }
   
   func getChildren() {
      guard let user = userSeission else { return }
      db.collection("users/\(user.uid)/children").getDocuments { snapshot, error in
         // TODO: handle error instead of just escaping
         guard let snapshot = snapshot, error == nil  else { return }
         
         DispatchQueue.main.async {
            self.children = snapshot.documents.compactMap({ queryDocumentSnapshot -> Child? in
               return try? queryDocumentSnapshot.data(as: Child.self)
            })
         }
      }
      
   }
   
   func signOut() {
      userSeission = nil
      try? Auth.auth().signOut()
   }
}

enum Grade: String, Codable, CaseIterable {
   case preschool, kindergarten, first
}
