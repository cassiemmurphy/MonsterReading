//
//  FlashCardView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/12/22.
//

import SwiftUI

struct FlashCardsView: View {
   
   // FIXME: Use this as base for multiple views with this style screen. Refactor name to meet these needs
   
    var body: some View {
       GeometryReader { geometry in
          ZStack {
             Rectangle()
                .fill(Color("MonsterLime"))
                .ignoresSafeArea()
                .overlay(alignment: .bottom, content: {
                   CardView(word: WordManager(word: "hat", definition: "Item worn on head"))
                      .background(Color("MonsterBase"))
                      .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
                      .frame(height: geometry.size.height * 0.4)
                      .offset(x: 0, y: geometry.size.height * 0.05)
                   // FIXME: Issues with landscape iphone view. Keep portrait or make offset changes based on orientaion.
                })
          }
       }
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsView()
    }
}

// FIXME: Use below to create stack vocab. Do not offset to see layers. 
/**
 @State private var cardTest = [WordManager](repeating: WordManager(word: "hat", definition: "item to be worn on head"), count: 10)
 @State private var words: [Word] = [Word]()
 
 let coreDM: CoreDataManager
 
  var body: some View {
     ZStack {
        VStack {
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
 
 
 
 */
