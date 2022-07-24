//
//  ChildViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/13/22.
//

import Foundation

class ChildViewModel: ObservableObject {
   @Published var child = Child(name: "", grade: .preschool, monster: "Monster1", studyLists: [], level: 1, points: 0)
   // TODO: Add published var of learned words?
   
}
