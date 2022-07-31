//
//  FlashCardView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/12/22.
//

import SwiftUI

struct FlashCardsView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   
   @StateObject private var flashcardVM = FlashcardViewModel()
   @State var showPopover = false
   
    var body: some View {
       GeometryReader { geometry in
          VStack {
             MenuTop(showPopover: $showPopover)
                .padding(.top)
             Image("LimeMelt")
                .resizable()
//                .scaledToFit()
                .frame(width: geometry.size.width, alignment: .center)
             ZStack {
                // FIXME: offset adjustments need checking
                ForEach(flashcardVM.words, id: \.id) { word in
                   CardView(word: word, cardHeight: geometry.size.height * 0.4, removal: {
                      if let index = flashcardVM.words.firstIndex(of: word) {
                         flashcardVM.words.remove(at: index)
                      }
                   }, moveCard: {
                      if let index = flashcardVM.words.firstIndex(of: word) {
                         flashcardVM.words.remove(at: index)
                         flashcardVM.words.insert(word, at: 0)
                      }
                   })
                }
             }.onAppear(perform: {
                flashcardVM.getFlashcardWords(child: authVM.childUser)
             })
          }.background(Color("MonsterLime"))
          .ignoresSafeArea()
          .iconPopover(show: $showPopover) {
             IconPopover()
          }
       }
    }
}

// FIXME: Issues with landscape iphone view. Keep portrait or make offset changes based on orientaion.

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
       FlashCardsView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}
