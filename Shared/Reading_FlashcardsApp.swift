//
//  Reading_FlashcardsApp.swift
//  Shared
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

@main
struct Reading_FlashcardsApp: App {
   @StateObject private var dataControler = DataController()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.managedObjectContext, dataControler.container.viewContext)
        }
    }
}
