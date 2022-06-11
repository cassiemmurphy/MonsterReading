//
//  CardView.swift
//
//  Created by Murphy, Cassie on 5/29/22.
//

import SwiftUI
import AVKit

struct CardView: View {
   var word: Word
   
   @State private var showDefinition = false
   @State private var offset = CGSize.zero
   @StateObject private var soundManager = SoundManager()
   
    var body: some View {
       ZStack {
          RoundedRectangle(cornerRadius: 25, style: .continuous)
             .fill(Color("MonsterBase"))
             .shadow(radius: 10)
          
          VStack {
             Text(word.word.uppercased())
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
             if showDefinition {
                Text(word.definition)
                   .font(.title)
                   .foregroundColor(.gray)
             }
             HStack {
                Spacer()
                Image(systemName: "mic.circle.fill")
                   .imageScale(.large)
                Spacer()
                Button(action: {
                   soundManager.playSound(sound: "https://audio.oxforddictionaries.com/en/mp3/hat__us_2.mp3")
                   soundManager.audioPlayer?.play()
                }, label: {
                   Image(systemName: "speaker.wave.2.fill")
                      .imageScale(.large)
                })

                Spacer()
             }
          }
          .padding()
          .multilineTextAlignment(.center)
       }
       .frame(width: 450, height: 250)
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
       CardView(word: Word(word: "hat", definition: "Item worn on head"))
    }
}

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}
