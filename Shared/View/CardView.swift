//
//  CardView.swift
//
//  Created by Murphy, Cassie on 5/29/22.
//

import SwiftUI

struct CardView: View {
   var word: WordManager
   
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
                Image(systemName: "mic.circle.fill")
                   .imageScale(.large)
                   .foregroundColor(.white)
                Spacer()
                Button(action: {
                   soundManager.playSound(sound: "https://audio.oxforddictionaries.com/en/mp3/hat__us_2.mp3")
                   soundManager.audioPlayer?.play()
                }, label: {
                   Image(systemName: "speaker.wave.2.fill")
                      .imageScale(.large)
                      .foregroundColor(.white)
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
                  // remove card
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
       CardView(word: WordManager(word: "hat", definition: "Item worn on head"))
    }
}


