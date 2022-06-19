//
//  MonsterPickViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import Foundation
import SwiftUI

class MonsterPickViewModel: ObservableObject {
   

}

struct Monster: Identifiable {
    var id = UUID()
    var name: String
}

let monsterAvitars = (1...8).map { Monster(name: "Monster\($0)") }
