//
//  ContentView.swift
//  Shared
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Text("Start Reading")
          .onTapGesture() {
             print("Show Card")
          }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       Group {
          ContentView()
       }
    }
}
