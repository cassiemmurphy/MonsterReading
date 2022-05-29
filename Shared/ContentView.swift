//
//  ContentView.swift
//  Shared
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       CardView(card: Card.example)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       Group {
          ContentView()
       }
    }
}
