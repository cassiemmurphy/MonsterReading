//
//  Monster_ReadingApp.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

@main
struct Monster_ReadingApp: App {
   @StateObject private var dataControler = DataController()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.managedObjectContext, dataControler.container.viewContext)
        }
    }
}
