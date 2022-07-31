//
//  StudyListsView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/1/22.
//

import SwiftUI

struct StudyListsView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var auth: AuthViewModel
   @ObservedObject var model = StudyListViewModel()
   
   
   /*
    TODO: add check mark next to study list already added and remove add button
    */
   
   @State var showLists = false
   @State var showPopover = false
   @State var gradeTitle = ""
   private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   
    var body: some View {
       VStack {
          MenuTop(showPopover: $showPopover)
          Text("Study Lists")
             .font(Font.custom("Helvetica Neue", size: 48))
             .fontWeight(.semibold)
             .foregroundColor(Color("MonsterSky"))
             .glowBorder(color: .black, lineWidth: 2)
          if showLists {
             VStack {
                HStack {
                   Button(action: {
                      showLists = false
                   }, label: {
                      Image(systemName: "chevron.left").foregroundColor(.white)
                   })
                   Spacer()
                   Text(gradeTitle)
                      .font(Font.custom("Helvetica Neue", size: 38))
                      .fontWeight(.semibold)
                      .foregroundColor(Color("MonsterSky"))
                      .glowBorder(color: .black, lineWidth: 2)
                   Spacer()
                }.padding()
                ScrollView {
                   LazyVGrid(columns: gridItemLayout) {
                      ForEach(model.lists) { list in
                         Button {
                            model.selectedList = list
                            withAnimation {
                               model.present()
                            }
                         } label: {
                            VStack {
                               Text(list.category.rawValue).font(Font.custom("Helvetica Neue", size: 24))
                               .foregroundColor(.black)
                               Text(list.title).font(Font.custom("Helvetica Neue", size: 24))
                               .foregroundColor(.black)}
                         }
                         .padding()
                         .background(.white)
                         .clipShape(RoundedRectangle(cornerRadius: 25))
                      }
                   }
                }
             }
             .overlay {
                if model.popupState.isPresented {
                   if let selectedList = model.selectedList {
                      StudyListPopupView(title: selectedList.title, words: selectedList.words) {
                         withAnimation {
                            model.dismiss()
                         }
                      } addList: {
                         auth.childUser?.studyLists.append(selectedList)
                         guard let child = auth.childUser, let user = auth.userSeission else { return }
                         model.addListToChild(user: user, child: child, list: selectedList)
                      }
                   }
                }
             }
          } else {
             VStack(spacing: 30) {
                ForEach(Grade.allCases, id: \.rawValue) { grade in
                   GradeButton(grade: grade, getList: { getStudyList(grade: grade) })
                }
             }.padding()
          }
          Spacer()
       }.background(Color("MonsterOrange"))
       .iconPopover(show: $showPopover) {
          IconPopover()
       }
    }
   
   func getStudyList(grade: Grade) {
 //     model.createLists()
      model.getStudyLists(grade: grade)
      gradeTitle = grade.rawValue
      showLists = true
   }

}

struct GradeButton: View {
   var grade: Grade
   var getList: () -> Void
   @State var isHovering = false
   
   var body: some View {
      Button {
         getList()
      } label: {
         HStack {
            Spacer()
            // TODO: Do we want to change to First Grade or leave as is?
            Text(grade.rawValue.capitalized).font(Font.custom("Helvetica Neue", size: 24))
               .foregroundColor(Color("MonsterBase"))
            Spacer()
         }.padding()
         
      }
      .padding()
      .background(isHovering ? .gray : .white)
     .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
     .shadow(color: .gray, radius: 2, x: 0, y: 1)
     .onHover { hovering in
        isHovering = hovering
     }
   }
}

struct StudyListsView_Previews: PreviewProvider {
    static var previews: some View {
       StudyListsView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}
