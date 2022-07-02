//
//  StudyListsView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import SwiftUI

struct StudyListsView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var appState: AppState
   @ObservedObject var model = StudyListViewModel()
   
   @State var showLists = false
   private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   
    var body: some View {
       VStack {
          MenuTop()
          Text("Study Lists").font(.largeTitle)
          if showLists {
             VStack {
                HStack {
                   Button(action: {
                      showLists = false
                   }, label: {
                      Image(systemName: "chevron.left").foregroundColor(.white)
                   })
                   Spacer()
                }.padding()
                ScrollView {
                   LazyVGrid(columns: gridItemLayout) {
                      ForEach(model.lists) { list in
                         VStack{
                            Text(list.title).font(.title3)
                            ForEach(list.words) { word in
                               Text(word.id)
                            }
                         }
                      }
                   }
                }
             }
          } else {
             VStack {
                GradeButton(grade: "Preschool", getList: { getStudyList(grade: "preschool") })
                GradeButton(grade: "Kindergarten", getList: { getStudyList(grade: "kindergarten") })
                GradeButton(grade: "First Grade", getList: { getStudyList(grade: "First Grade") })
             }.padding()
          }
          Spacer()
       }.background(Color("MonsterOrange"))
    }
   
   func getStudyList(grade: String) {
      model.getStudyLists()
      showLists = true
   }
}

struct GradeButton: View {
   var grade: String
   var getList: () -> Void
   
   var body: some View {
      Button {
         getList()
      } label: {
         HStack {
            Spacer()
            Text(grade)
            Spacer()
         }.padding()
         
      }
      .padding()
     .background(.white)
     .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
   }
}

struct StudyListsView_Previews: PreviewProvider {
    static var previews: some View {
       StudyListsView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AppState(loggedIn: true))
    }
}

//struct GradeButtonStyle: ButtonStyle {
//   @State var isHovering = false
//   var backgroundColor = Color.white
////   var hoverColor = Color(TSKThemeManager.sharedInstance.currentTheme.)
//
//   func makeBody(configuration: Configuration) -> some View {
//        configuration.label
////          .buttonStyle(.plain)
//          .frame(width: width, height: 26)
//          .background(backgroundColor)
//          .clipShape(RoundedRectangle(cornerRadius: 3))
//          .shadow(color: Color(white: 0, opacity: 0.15), radius: 3, x: 0, y: 1)
//    }
//}
