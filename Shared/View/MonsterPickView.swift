//
//  MonsterPickView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct MonsterPickView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   
    var body: some View {
       MenuTop(previousPage: .login)
       Text("Change Monster")
    }
}

struct MonsterPickView_Previews: PreviewProvider {
    static var previews: some View {
        MonsterPickView()
    }
}
