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
   case addChild
   case home
   case flashCards
   case studyLists
   case childSelection
}

class NavigationViewModel: ObservableObject {
   @Published var currentPage: NavPage = .welcome
   
}
