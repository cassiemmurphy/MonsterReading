//
//  NavigationViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import Foundation
import SwiftUI

enum NavPage {
   case welcome
   case login
   case monsterPick
   case home
   case flashCards
   case studyLists
}

class NavigationViewModel: ObservableObject {
   @Published var currentPage: NavPage = .welcome
   
   
}
