//
//  CardView.swift
//
//  Created by Murphy, Cassie on 5/29/22.
//

import SwiftUI

struct CardView: View {
   var word: WordViewModel
   @State var cardHeight: CGFloat
   var removal: (() -> Void)? = nil
   var moveCard: (() -> Void)? = nil
   
   @State private var correctCount = 0
   @State private var showDefinition = false
   @State private var offset = CGSize.zero
   @StateObject private var soundManager = SoundManager()
   
   
    var body: some View {
       ZStack {
          VStack {
             Text(word.word.uppercased())
                .font(.system(size: 90))
                .fontWeight(.heavy)
                .foregroundColor(.black)
             if showDefinition {
                Text(word.definition)
                   .font(.title)
                   .foregroundColor(.gray)
             }
             Spacer()
             HStack {
                Spacer()
                Image("Talk")
                   .resizable()
                   .frame(width: 100, height: 100)
                Spacer()
                Button(action: {
                   soundManager.playSound(sound: word.pronunciation, word: word.word)
                }, label: {
                   Image("PlaySound")
                      .resizable()
                      .frame(width: 100, height: 100)
                })
                Spacer()
             }
             Spacer()
          }
          .padding()
       }
       .withOverlayStyle(bgColor: Color("MonsterBase"),
                         height: cardHeight,
                         offsetY: 30)
       .rotationEffect(.degrees(Double(offset.width / 5)))
       .offset(x: offset.width * 5, y: 0)
       .opacity(2 - Double(abs(offset.width / 50)))
       .gesture(
         DragGesture()
            .onChanged { gesture in
               offset = gesture.translation
            }
            .onEnded { _ in
               if abs(offset.width) > 100 {
                  if offset.width > 0 {
                     if correctCount == 3 {
                        // FIXME: remove from pile and change word to LEARNED
                        removal?()
                        print("LEARNED WORD")
                     } else {
                        correctCount += 1
                        moveCard?()
                     }
                  } else {
                     correctCount = 0
                     moveCard?()
                  }

               }
               else {
                  offset = .zero
               }
            }
       )
       .onTapGesture {
          showDefinition.toggle()
       }
       .animation(.spring(), value: offset)
    }
}


struct CardView_Preview: PreviewProvider {
   static var previews: some View {
      CardView(word: FlashcardViewModel.sampleWord, cardHeight: 300)
    }
}
