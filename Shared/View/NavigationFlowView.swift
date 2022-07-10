//
//  NavigationFlowView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct NavigationFlowView: View {
   @EnvironmentObject var authVM: AuthViewModel
   @EnvironmentObject var navigationVM: NavigationViewModel
   
   var body: some View {
      switch navigationVM.currentPage {
      case .welcome:
         WelcomeView()
      case .login:
         LoginView()
      case .monsterPick:
         MonsterPickView()
      case .home:
         HomeView()
      case .flashCards:
         FlashCardsView()
      case .studyLists:
         StudyListsView()
      }
   }
}

struct NavigationFlowView_Previews: PreviewProvider {
    static var previews: some View {
       NavigationFlowView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}
