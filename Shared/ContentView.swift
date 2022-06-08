//
//  ContentView.swift
//  Shared
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct ContentView: View {
//   @StateObject var viewModel = ViewModel()
//   @State var dictionaryConnection = DictionaryConnection()
   @State var dataController = DataController()
   @State private var cards = [Card](repeating: Card.example, count: 10)
  // @FetchRequest(sortDescriptors: []) var card: FetchedResults<ABC>
   
    var body: some View {
       ZStack {
          VStack {
             ZStack {
                ForEach(0..<cards.count, id: \.self) { index in
                   CardView(card: cards[index])
                      .stacked(at: index, in: cards.count)
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
