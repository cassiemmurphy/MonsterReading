//
//  FlashCardView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/12/22.
//

import SwiftUI

struct FlashCardsView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var appState: AppState
   
   @StateObject private var flashcardVM = FlashcardViewModel()
   @State private var cards = [WordViewModel](repeating: FlashcardViewModel.sampleWord, count: 10)
   
    var body: some View {
       GeometryReader { geometry in
          VStack {
             MenuTop()
                .padding(.top)
             Image("LimeMelt")
                .resizable()
//                .scaledToFit()
                .frame(width: geometry.size.width, alignment: .center)
             ZStack {
                // FIXME: offset adjustments need checking
                ForEach(flashcardVM.words, id: \.id) { word in
                   CardView(word: word, cardHeight: geometry.size.height * 0.4)
                }
             }.onAppear(perform: {
                flashcardVM.getStudyWords()
             })
          }.background(Color("MonsterLime"))
             .ignoresSafeArea()
       }
    }
}

// FIXME: Issues with landscape iphone view. Keep portrait or make offset changes based on orientaion.

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
       FlashCardsView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AppState(loggedIn: true))
    }
}
