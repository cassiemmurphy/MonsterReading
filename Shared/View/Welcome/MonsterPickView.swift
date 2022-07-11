//
//  MonsterPickView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct AddChildView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   
   private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   @State var monsterSelected = false
   @State var showMonsters = false
   @State var childName = ""
   @State var childGrade = ""
   @State var childPin = ""
   @State var confirmPin = ""
   @State var monsterName = ""
   
   
   // FIXME: update spacing
   
    var body: some View {
       GeometryReader { geo in
          VStack {
             MenuTop(previousPage: .login)
             Spacer()
             Spacer()
             VStack {
               if showMonsters {
                   LazyVGrid(columns: gridItemLayout, spacing: 10) {
                      ForEach(monsterAvitars.indices) { index in
                         Button(action: {
                            monsterName = monsterAvitars[index].name
                            monsterSelected = true
                         }, label: {
                            Image(monsterAvitars[index].name)
                               .resizable()
                               .scaledToFit()
                               .frame(minWidth: 0, maxWidth: .infinity)
                               .frame(height: 140)
                         })
                      }
                   }.padding()
                  Button("Save") {
                     showMonsters = false
                  }
               } else {
                  VStack(alignment: .leading, spacing: 20) {
                     Spacer()
                     Text("Enter the following details to add a child")
                        .padding(.bottom)
                     VStack {
                        // FIXME: Prompts
                        EntryField(placeholder: "Child Name", prompt: "", field: $childName)
                        EntryField(placeholder: "Child Grade", prompt: "", field: $childGrade)
                     }
                     Spacer()
                     Button("Pick your Monster") {
                        showMonsters = true
                     }
                  }
               }
                WelcomeNavigation(isEnabled: $monsterSelected,
                                  pageNumber: 3,
                                  accentColor: Color("MonsterPurple"),
                                  action: {
                   authVM.addChild(name: childName, grade: childGrade, monster: monsterName)
                }).padding()
             }.padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
                .frame(height: geo.frame(in: .local).height * 0.8, alignment: .bottom)
                .offset(x: .zero, y: 50)
          }.background(Color("MonsterPurple"))
       }
    }
}

struct MonsterPickView_Previews: PreviewProvider {
    static var previews: some View {
       AddChildView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}


/**
 Button("Add child") {
    authVM.addChild(name: "Nathan", grade: "First", pin: "234567", monster: "Monster3")
 }
 */
