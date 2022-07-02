//
//  StudyListsView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import SwiftUI

struct StudyListsView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @ObservedObject var model = StudyListViewModel()
   
    var body: some View {
       List(model.list) { item in
          Text(item.title)
       }
    }
   
   init() {
      model.getData()
   }
}

struct StudyListsView_Previews: PreviewProvider {
    static var previews: some View {
       StudyListsView().environmentObject(NavigationViewModel())
    }
}
