//
//  Monster_ReadingApp.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI
import FirebaseCore

class AppState: ObservableObject {
   @Published var loggedIn: Bool
   
   init(loggedIn: Bool) {
      self.loggedIn = loggedIn
   }
}


@main
struct Monster_ReadingApp: App {
   @ObservedObject var appState = AppState(loggedIn: false)
   @StateObject var navigationVM = NavigationViewModel()
   
   init() {
      FirebaseApp.configure()
   }

    var body: some Scene {
        WindowGroup {
           if appState.loggedIn {
              HomeView()
                 .environmentObject(appState)
                 .environmentObject(navigationVM)
           } else {
              NavigationFlowView()
                 .environmentObject(appState)
                 .environmentObject(navigationVM)
           }
        }
    }
}
