//
//  DictionaryConnection.swift
//  Reading Flashcards
//
//  Created by Murphy, Cassie on 6/5/22.
//

import Foundation

class DictionaryConnection: ObservableObject {
   //FIXME: Need to populate array OR add words to Core Data when called upon
   @Published var words = [Word]()
   
   /// Shared instance. FIXME: Do I need this??
   public static let shared = DictionaryConnection()
   public typealias RequestHandler = ((_ data: [String: Any]?, _ error: Error?) -> Void)
   
   private let appId = "f9e70613"
   private let appKey = "3a7c21194f6b52c89b3084afbfd5ad60"
   private let language = "en-us/"
   private let baseURL = "https://od-api.oxforddictionaries.com/api/v2/entries/"

   public func fetchVocabData(word: String, filters: String? = nil) {
      var urlString = baseURL + language + word.lowercased() + "?"
      if let filters = filters {
         urlString += "fields=\(filters)&"
      }
      urlString += "strictMatch=true"
      
      performRequest(withURL: urlString)
   }
   
   private func performRequest(withURL urlString: String) {
      guard let url = URL(string: urlString) else { return }
      var request = URLRequest(url: url)
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue(appId, forHTTPHeaderField: "app_id")
      request.addValue(appKey, forHTTPHeaderField: "app_key")
      
      URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
         guard let data = data, error == nil else { return }
         
         do {
            let word = try JSONDecoder().decode(Word.self, from: data)
            DispatchQueue.main.async {
               self?.words.append(word)
            }
         } catch {
            print(error)
         }
      }.resume()
   }
}
   

