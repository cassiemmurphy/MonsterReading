//
//  Child.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/10/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Child: Identifiable, Codable {
   @DocumentID var id: String?
   var name: String
   var grade: Grade
   var monster: String

}

enum Grade: String, Codable, CaseIterable {
   case preschool, kindergarten, first
}
