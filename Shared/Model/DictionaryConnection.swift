//
//  DictionaryConnection.swift
//
//  Created by Murphy, Cassie on 6/5/22.
//

import Foundation

class DictionaryConnection: ObservableObject {

   public typealias RequestHandler = ((_ data: [WordManager: Any]?, _ error: Error?) -> Void)
   public var vocabArray: [WordManager] = []
   
   private let appId = "f9e70613"
   private let appKey = "3a7c21194f6b52c89b3084afbfd5ad60"
   private let language = "en-us/"
   private let baseURL = "https://od-api.oxforddictionaries.com/api/v2/entries/"
//
//   public func getPronunciation(word: String) -> String {
//      fetchVocabData(word: word)
//      return pronunciation ?? ""
//   }

   public func fetchVocabData(word: String) {
      var urlString = baseURL + language + word.lowercased() + "?"
      urlString += "strictMatch=true"
      
      performRequest(withURL: urlString)
   }
   
//   func fetchPronunciation(url: URL) async throws -> WordManager {
//      let (data, response) = try await URLSession.shared.data(from: url)
//      
////      guard let word = WordManager(data: data) else {
////         throw Error.self
////      }
//   }
   
   private func performRequest(withURL urlString: String) {
      guard let url = URL(string: urlString) else { return }
      var request = URLRequest(url: url)
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue(appId, forHTTPHeaderField: "app_id")
      request.addValue(appKey, forHTTPHeaderField: "app_key")
      
      URLSession.shared.dataTask(with: request) { data, _, error in
         guard let data = data, error == nil else { return }
         
         do {
            let word = try JSONDecoder().decode(WordManager.self, from: data)
            DispatchQueue.main.async {
               self.vocabArray.append(word)
            }
         } catch {
            print(error)
         }
      }.resume()
   }
   
   public func getData(word: String, _ completion: @escaping(WordManager?, Error?) -> Void) {
      var urlString = baseURL + language + word.lowercased() + "?"
      urlString += "strictMatch=true"
      guard let url = URL(string: urlString) else { return }
      
      var request = URLRequest(url: url)
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue(appId, forHTTPHeaderField: "app_id")
      request.addValue(appKey, forHTTPHeaderField: "app_key")

      let session = URLSession(configuration: .default)


      let task = session.dataTask(with: request) {(data, response, error) in
        if let error = error {
            print("error is \(error.localizedDescription)")
            completion(nil, error)
            return
        }

        guard let data = data else { return }

         do {
            let word = try JSONDecoder().decode(WordManager.self, from: data)
            completion(word, nil)
        } catch (let decodingError) {
            completion(nil, decodingError)
        }
      }
      
      task.resume()
   }
}
   

