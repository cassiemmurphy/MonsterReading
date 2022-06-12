//
//  ContentView.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       NavigationView {
          NavigationLink(destination: FlashCardsView()) {
             Text("FlashCards")
          }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
