//
//  SoundManager.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/11/22.
//

import Foundation
import AVKit

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?

   func playSound(sound: String, word: String){
       if let url = URL(string: sound) {
          self.audioPlayer = AVPlayer(url: url)
          audioPlayer?.play()
      } else {
        let utterance = AVSpeechUtterance(string: sound)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
      }
    }
   
   // FIXME: Include speech work in here
}
