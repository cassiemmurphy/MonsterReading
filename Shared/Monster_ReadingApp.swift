//
//  Monster_ReadingApp.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI
import Firebase

@main
struct Monster_ReadingApp: App {
   @StateObject var authVM = AuthViewModel()
   @StateObject var navigationVM = NavigationViewModel()
   
   init() {
      FirebaseApp.configure()
   }

    var body: some Scene {
        WindowGroup {
           NavigationFlowView()
              .environmentObject(authVM)
              .environmentObject(navigationVM)
              .onAppear {
                 navigationVM.currentPage = authVM.userSeission == nil ? .welcome : .childSelection
              }
        }
    }
}
