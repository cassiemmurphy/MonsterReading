//
//  FlashCardView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/12/22.
//

import SwiftUI

struct FlashCardsView: View {
   
    var body: some View {
       GeometryReader { geometry in
          VStack {
             Image("LimeMelt")
                .resizable()
//                .scaledToFit()
                .frame(width: geometry.size.width, alignment: .center)
             CardView(word: WordManager(word: "hat",
                                        definition: "Item worn on head"))
                .withOverlayStyle(bgColor: Color("MonsterBase"),
                                  height: geometry.size.height * 0.4,
                                  offsetY: geometry.size.height * 0.01)
                                 // FIXME: offset adjustments need checking
          }.background(Color("MonsterLime"))
             .ignoresSafeArea()
       }
    }
}

// FIXME: Issues with landscape iphone view. Keep portrait or make offset changes based on orientaion.

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
