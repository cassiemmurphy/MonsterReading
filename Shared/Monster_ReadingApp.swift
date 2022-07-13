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
           if authVM.userSeission == nil {
              NavigationFlowView()
                 .environmentObject(authVM)
                 .environmentObject(navigationVM)
           } else {
              ChildSelectionView()
                 .environmentObject(authVM)
                 .environmentObject(navigationVM)
           }
        }
    }
}
