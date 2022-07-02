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

   func playSound(sound: String, word: String) {
      if verifyUrl(urlString: sound) {
         if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
            audioPlayer?.play()
        }
      } else {
        speakWord(word: word)
      }
    }
   
   func speakWord(word: String) {
      let utterance = AVSpeechUtterance(string: word)
      utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
      utterance.rate = 0.5
      
      let synthesizer = AVSpeechSynthesizer()
      synthesizer.speak(utterance)
   }
   
   func verifyUrl (urlString: String?) -> Bool {
      if let urlString = urlString {
          if let url = NSURL(string: urlString) {
              return UIApplication.shared.canOpenURL(url as URL)
          }
      }
      return false
  }
   
   // FIXME: Include speech work in here
}


