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
   @Published var child = String
   
   init() {
      self.userSeission = Auth.auth().currentUser
   }
   
   func login(email: String, password: String) -> Bool{
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
         if let error = error {
            print("Failed to login with error \(error.localizedDescription)")
            return
         }
         
         guard let user = result?.user else { return }
         self.userSeission = user
      }
      
      return self.userSeission == nil
   }
   
   func register(name: String, email: String, password: String) {
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
               print("User created..")
            }
      }
   }
   
   func addChild(name: String, grade: String, monster: String) {
      guard let user = userSeission else { return }
      
      let data = ["name": name,
                  "grade": grade,
                  "monsterName": monster]
      
      Firestore.firestore().collection("users/\(user.uid)/children")
         .document()
         .setData(data) { _ in
            print("child created")
         }
      
   }
   
   func signOut() {
      userSeission = nil
      try? Auth.auth().signOut()
   }
}
