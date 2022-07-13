//
//  ChildViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/13/22.
//

import Foundation

class ChildViewModel: ObservableObject {
   @Published var child = Child(name: "", grade: .preschool, monster: "")
   
}
