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

    var body: some Scene {
        WindowGroup {
           ContentView()
              .environmentObject(appState)
           WelcomeView()
              .environmentObject(appState)
        }
    }
}
