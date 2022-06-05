//
//  DictionaryConnection.swift
//  Reading Flashcards
//
//  Created by Murphy, Cassie on 6/5/22.
//

import Foundation

class DictionaryConnection: NSObject {
   let word = "flat"
   lazy var endPoint: String = { return
      "https://www.dictionaryapi.com/api/v3/references/learners/json/\(self.word)?key=e32fbc38-726f-48e6-9116-5491a4c39fcc"
   } ()
   
   func getDataWith(completion: @escaping (Result<[String: AnyObject]>) -> Void) {
      guard let url = URL(string: endPoint) else { return }
      
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data, error == nil else { return }
         do {
            if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
               DispatchQueue.main.async {
                  completion(.Success(json))
               }
               print(json)
            }
         } catch let error {
            print(error)
         }
      }.resume()
   }
   
}

enum Result<T> {
    case Success(T)
    case Error(String)
}





class ViewModel: ObservableObject {
   @Published var cards: [Card] = []
   
   func fetch() {
      let studyList = ["hat", "bat", "cat", "flat"]
      
      for word in studyList {
         guard let url = URL(string: "https://od-api.oxforddictionaries.com/api/v2/words/en-us?q=\(word)")
                     else { return }
 
         let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            //Convert to JSON
            do {
               let card = try JSONDecoder().decode([Card].self, from: data)
               DispatchQueue.main.async {
                  self?.cards += card
               }
            }
            catch {
               print(error)
            }
         }
         
         task.resume()
      }
      

   }
}
