//
//  StudyList.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import Foundation
import FirebaseFirestoreSwift

struct StudyList: Identifiable, Codable {
   @DocumentID var id: String?
   var title: String
   // TODO: Change grade to an Enum??
   var grade: String
   var words: [VocabWord]
}

struct VocabWord: Identifiable, Codable {
   var id: String
   var definition: String
   var pronunciation, image: String?
}
