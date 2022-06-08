//
//  DictionaryConnection.swift
//  Reading Flashcards
//
//  Created by Murphy, Cassie on 6/5/22.
//

import Foundation

class DictionaryConnection: NSObject {
   /// Shared instance. FIXME: Do I need this??
   public static let shared = DictionaryConnection()
   
   /// App identifier.  FIXME FIXME
   private let appId = "f9e70613"
   private let appKey = "3a7c21194f6b52c89b3084afbfd5ad60"
   private let language = "en-us"
   private let baseURL = "https://od-api.oxforddictionaries.com/api/v2/entries/"

    
    public typealias RequestHandler = ((_ data: [String: Any]?, _ error: Error?) -> Void)
    
   // FIXME
   public func fetchVocabData(word: String, filters: String? = nil) {
      var urlString = baseURL + language + "/" + word.lowercased() + "?"
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

      let session = URLSession.shared
      session.dataTask(with: request, completionHandler: { data, response, error in
          if let response = response,
              let data = data,
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                 print(response)
                 print(jsonData)
          } else {
             print(error ?? "Unknown error")
             print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
          }
      }).resume()
   }
}
   
      



//
//
//
//enum Result<T> {
//    case Success(T)
//    case Error(String)
//}

//class ViewModel: ObservableObject {
//   @Published var cards: [Card] = []
//   
//   func fetch() {
//      let studyList = ["hat", "bat", "cat", "flat"]
//      
//      for word in studyList {
//         guard let url = URL(string: "https://od-api.oxforddictionaries.com/api/v2/words/en-us?q=\(word)")
//                     else { return }
// 
//         let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else { return }
//            
//            //Convert to JSON
//            do {
//               let card = try JSONDecoder().decode([Card].self, from: data)
//               DispatchQueue.main.async {
//                  self?.cards += card
//               }
//            }
//            catch {
//               print(error)
//            }
//         }
//         
//         task.resume()
//      }
//   }
//   let word = "flat"
//   lazy var endPoint: String = { return
//      "https://od-api.oxforddictionaries.com/api/v2/words/en-us?q=\(word)"
//   } ()
//   
//   func getDataWith(completion: @escaping (Result<[String: AnyObject]>) -> Void) {
//      guard let url = URL(string: endPoint) else { return }
//      
//      URLSession.shared.dataTask(with: url) { (data, response, error) in
//         guard let data = data, error == nil else { return }
//         do {
//            if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
//               DispatchQueue.main.async {
//                  completion(.Success(json))
//               }
//               print(json)
//            }
//         } catch let error {
//            print(error)
//         }
//      }.resume()
//   }
//}



//{
//  "id": "ace",
//  "metadata": {
//    "operation": "retrieve",
//    "provider": "Oxford University Press",
//    "schema": "RetrieveEntry"
//  },
//  "results": [
//    {
//      "id": "ace",
//      "language": "en-gb",
//      "lexicalEntries": [
//        { "entries": [ {
//              "etymologies": [ "Middle English (denoting the ‘one’ on dice): via Old French from Latin as ‘unity, a unit’" ],
//              "homographNumber": "100",
//              "pronunciations": [
//                {
//                  "audioFile": "https://audio.oxforddictionaries.com/en/mp3/ace__gb_3.mp3",
//                  "dialects": [ "British English" ],
//                  "phoneticNotation": "IPA",
//                  "phoneticSpelling": "eɪs"
//                }
//              ],
//              "senses": [
//                {
//                  "definitions": [ "a playing card with a single spot on it, ranked as the highest card in its suit in most card games" ],
//                  "domainClasses": [ { "id": "cards", "text": "Cards" } ],
//                  "examples": [
//                    { "text": "the ace of diamonds" },
//                    { "registers": [ { "id": "figurative", "text": "Figurative" } ], "text": "life had started dealing him aces again" }
//                  ],
//                  "id": "m_en_gbus0005680.006",
//                  "semanticClasses": [{ "id": "playing_card", "text": "Playing_Card" }],
//                  "shortDefinitions": [ "playing card with single spot on it, ranked as highest card in its suit in most card games" ]
//                },
//                {
//                  "definitions": [ "a person who excels at a particular sport or other activity" ],
//                  "domainClasses": [ { "id": "sport", "text": "Sport" } ],
//                  "examples": [ { "text": "a motorcycle ace" } ],
//                  "id": "m_en_gbus0005680.010",
//                  "registers": [{ "id": "informal", "text": "Informal" }],
//                  "semanticClasses": [{ "id": "sports_player", "text": "Sports_Player" }],
//                  "shortDefinitions": [ "person who excels at particular sport or other activity" ],
//                  "subsenses": [
//                    { "definitions": ["a pilot who has shot down many enemy aircraft"],
//                      "domainClasses": [{ "id": "air_force", "text": "Air_Force"}],
//                      "examples": [ { "text": "a Battle of Britain ace"}],
//                      "id": "m_en_gbus0005680.011",
//                      "semanticClasses": [{"id": "aviator", "text": "Aviator"}],
//                      "shortDefinitions": [ "pilot who has shot down many enemy aircraft" ] }
//                  ],
//                  "synonyms": [
//                    {"language": "en", "text": "expert" },
//                    {"language": "en", "text": "master" }
//                  ],
//                  "thesaurusLinks": [{"entry_id": "ace", "sense_id": "t_en_gb0000173.001"}]
//                }
//              ] //ends senses L4
//            } ], // ends entries L3
//          "language": "en-gb",
//          "lexicalCategory": { "id": "noun", "text": "Noun" },
//          "phrases": [
//            {"id": "an_ace_up_one%27s_sleeve", "text": "an ace up one's sleeve" },
//            {"id": "hold_all_the_aces", "text": "hold all the aces"},
//            {"id": "play_one%27s_ace", "text": "play one's ace"},
//            {"id": "within_an_ace_of",  "text": "within an ace of"}
//          ],
//          "text": "ace"
//        }
//      ], // ENDS LEXICALENTRIES
//      "type": "headword",
//      "word": "ace"
//    },
//    {
//      "id": "ace",
//      "language": "en-gb",
//      "lexicalEntries": [
//        {
//          "entries": [ ],
//          "language": "en-gb",
//          "lexicalCategory": { },
//          "text": "ace"
//        }
//      ],
//      "type": "headword",
//      "word": "ace"
//    }
//  ],
//  "word": "ace"
//}
