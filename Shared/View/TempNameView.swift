//
//  FlashCardView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/12/22.
//

import SwiftUI

struct TempNameView: View {
   @State private var flashcardVM = FlashcardViewModel()
   
   var studyListArray = ["hat", "cat", "bat", "flat"]
   // FIXME: Use this as base for multiple views with this style screen. Refactor name to meet these needs
   
    var body: some View {
       
       GeometryReader { geometry in
          VStack {
             Image("LimeMelt")
                .resizable()
//                .scaledToFit()
                .frame(width: geometry.size.width, alignment: .center)
             ZStack {
                // FIXME: offset adjustments need checking
                ForEach(flashcardVM.words, id: \.id) { word in
                   FlashcardView(word: word)
                      .withOverlayStyle(bgColor: Color("MonsterBase"),
                                        height: geometry.size.height * 0.4,
                                        offsetY: geometry.size.height * 0.01)
                }
             }
          }.background(Color("MonsterLime"))
             .onAppear(perform: {
                flashcardVM.addStudyList(studyList: studyListArray)
             })
       }
    }
}

// FIXME: Issues with landscape iphone view. Keep portrait or make offset changes based on orientaion.

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
       TempNameView()
    }
}
