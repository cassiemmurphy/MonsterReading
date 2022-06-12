//
//  ContentView.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct ContentView: View {
   @State private var cardTest = [WordManager](repeating: WordManager(word: "hat", definition: "item to be worn on head"), count: 10)
   @State private var words: [Word] = [Word]()
   
   let coreDM: CoreDataManager
   
    var body: some View {
       ZStack {
          VStack {
             Button("Add") {
                print("Add CD")
                coreDM.saveWord(id: "bat", definition: "bat definition")
                coreDM.saveWord(id: "hat", definition: "hat definition")
                words = coreDM.getAllWords()
             }
             List {
                ForEach(words, id: \.self) { word in
                   Text(word.id ?? "")
                }.onDelete(perform: { indexSet in
                   indexSet.forEach { index in
                      let word = words[index]
                      coreDM.removeWord(word: word)
                      words = coreDM.getAllWords()
                   }
                })
             }
             ZStack {
                ForEach(0..<cardTest.count, id: \.self) { index in
                   CardView(word: cardTest[index])
                      .stacked(at: index, in: cardTest.count)
                      .background(Color("MonsterBase"))
                      .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
             }
          }
       }
       .onAppear {
          DictionaryConnection.shared.fetchVocabData(word: "flat")
          words = coreDM.getAllWords()
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
          ContentView(coreDM: CoreDataManager())
       }
    }
}
