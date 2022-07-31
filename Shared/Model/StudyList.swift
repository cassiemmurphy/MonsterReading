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
   var grade: Grade
   var words: [VocabWord]
   var category: Category
}

struct VocabWord: Identifiable, Codable, Equatable {
   var id: String
   var definition: String?
   var pronunciation, image: String?
   var points: Int
   var learned = false
}

enum Category: String, Codable, CaseIterable {
   case sight = "SWT Sight Words",
        letter = "Letters",
        sounds = "Vowel and Consenent Sounds"
}
