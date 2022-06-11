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

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
   
   // FIXME: Include speech work in here
}
