//
//  MonsterPickView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct AddChildView: View {
   var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   @State var showMonsters = false
   @State var isHovering = false
   @StateObject var model = ChildViewModel()
   var saveChild: (Child) -> Void
   
   /*
    TODO: ...
    Style Save Child
    Fix monster hover
    Fix Picker style
    */
   
   
   
    var body: some View {
       VStack {
          if showMonsters {
             LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(monsterAvitars.indices) { index in
                   Button(action: {
                      model.child.monster = monsterAvitars[index].name
                      showMonsters = false
                   }, label: {
                      Image(monsterAvitars[index].name)
                         .resizable()
                         .scaledToFit()
                         .frame(minWidth: 0, maxWidth: .infinity)
                         .frame(height: 140)
                   })
                }
             }.padding()
          } else {
             VStack(alignment: .leading, spacing: 20) {
                Text("Enter the following details to add a child")
                   .padding(.bottom)
                VStack {
                   Button {
                      showMonsters = true
                   } label: {
                      ZStack {
                         if isHovering {
                            Text("Edit")
                         }
                         Image(model.child.monster)
                            .resizable()
                            .scaledToFit()
                            .opacity(isHovering ? 0.5 : 1.0)
                            .onHover { hovering in
                               isHovering = hovering
                            }
                      }
                      .frame(width: 100)
                      .clipShape(RoundedRectangle(cornerRadius: 25))
                   }
                   TextField("Child Name", text: $model.child.name)
                      .padding(10)
                      .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.gray, lineWidth: 1))
                   Picker("Child Grade", selection: $model.child.grade) {
                      ForEach(Grade.allCases, id: \.self) { grade in
                         Text(grade.rawValue.capitalized)
                      }.padding(10)
                         .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.gray, lineWidth: 1))
                   }
                   
                }
                Button("Save Child") {
                   saveChild(model.child)
                }.disabled(model.child.name.isEmpty || model.child.monster.isEmpty)
             }.padding()
          }
       }
    }
}

struct MonsterPickView_Previews: PreviewProvider {
    static var previews: some View {
       AddChildView(saveChild: {_ in })
    }
}
