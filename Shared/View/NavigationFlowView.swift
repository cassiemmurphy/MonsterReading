//
//  NavigationFlowView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct NavigationFlowView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   
   var body: some View {
      switch navigationVM.currentPage {
      case .welcome:
         WelcomeView()
      case .login:
         LoginView()
      case .monsterPick:
         MonsterPickView()
//      case .home:
//         print("Home view goes here")
      }
   }
}

struct NavigationFlowView_Previews: PreviewProvider {
    static var previews: some View {
       NavigationFlowView().environmentObject(NavigationViewModel())
    }
}
