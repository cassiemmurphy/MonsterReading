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
   
   @State var showLists = false
   private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   
    var body: some View {
       VStack {
          MenuTop()
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
                }.padding()
                ScrollView {
                   LazyVGrid(columns: gridItemLayout) {
                      ForEach(model.lists) { list in
                         Button {
                            withAnimation {
                               model.present()
                            }
                         } label: {
                            Text(list.title).font(Font.custom("Helvetica Neue", size: 24))
                               .foregroundColor(.black)
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
                   StudyListPopupView {
                      withAnimation {
                         model.dismiss()
                      }
                   }
                }
             }
          } else {
             VStack {
                GradeButton(grade: "Preschool", getList: { getStudyList(grade: "preschool") })
                GradeButton(grade: "Kindergarten", getList: { getStudyList(grade: "kindergarten") })
                GradeButton(grade: "First Grade", getList: { getStudyList(grade: "firstGrade") })
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
   @State var isHovering = false
   
   var body: some View {
      Button {
         getList()
      } label: {
         HStack {
            Spacer()
            Text(grade).font(Font.custom("Helvetica Neue", size: 24))
               .foregroundColor(Color("MonsterBase"))
            Spacer()
         }.padding()
         
      }
      .padding()
      .background(isHovering ? .gray : .white)
     .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
     .shadow(color: .gray, radius: 2, x: 0, y: 1)
     .onHover { hovering in
        print(hovering)
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
