//
//  FlashcardView.swift
//
//  Created by Murphy, Cassie on 5/29/22.
//

import SwiftUI

struct FlashcardView: View {
   var word: WordViewModel
   
   @State private var showDefinition = false
   @State private var offset = CGSize.zero
   @StateObject private var soundManager = SoundManager()
   @ObservedObject private var viewModel = FlashcardViewModel()
   
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
                   soundManager.playSound(sound: word.pronunciation)
                   soundManager.audioPlayer?.play()
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
                  // FIXME: Move card to the back of the list instead of remove it.
               }
               else {
                  offset = .zero
               }
            }
       )
       .onTapGesture {
          showDefinition.toggle()
       }
    }
}


