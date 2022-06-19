//
//  Monster_ReadingApp.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

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

    var body: some Scene {
        WindowGroup {
           NavigationFlowView().environmentObject(navigationVM)
           
//           if appState.loggedIn {
//              ContentView()
//                 .environmentObject(appState)
//           } else {
//              WelcomeView()
//                 .environmentObject(appState)
//           }
        }
    }
}
