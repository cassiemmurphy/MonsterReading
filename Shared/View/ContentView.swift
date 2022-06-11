//
//  ContentView.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct ContentView: View {
   @State var dataController = DataController()
   @State private var words = [Word](repeating: Word(word: "hat", definition: "item to be worn on head"), count: 10)
  // @FetchRequest(sortDescriptors: []) var card: FetchedResults<ABC>
   
    var body: some View {
       ZStack {
          VStack {
             ZStack {
                ForEach(0..<words.count, id: \.self) { index in
                   CardView(word: words[index])
                      .stacked(at: index, in: words.count)
                }
             }
          }
       }
       .onAppear {
          DictionaryConnection.shared.fetchVocabData(word: "flat")
       }
    }
}

extension View {
   func stacked(at position: Int, in total: Int) -> some View {
      let offset = Double(total - position)
      return self.offset(x: 0, y: offset * 10)
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       Group {
          ContentView()
       }
    }
}
