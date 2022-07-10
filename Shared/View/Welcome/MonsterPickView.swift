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
                            print(monsterAvitars[index].name)
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
                        EntryField(placeholder: "Child Name", field: $childName)
                        EntryField(placeholder: "Child Grade", field: $childGrade)
                        EntryField(placeholder: "Child Pin", field: $childPin)
                           .keyboardType(.numberPad)
                        EntryField(placeholder: "Child Pin", field: $confirmPin)
                           .keyboardType(.numberPad)
                     }
                     Spacer()
                     Button("Pick your Monster") {
                        showMonsters = true
                     }
                  }
               }
                
                WelcomeNavigation(isEnabled: $monsterSelected, nextPage: .home, pageNumber: 3, accentColor: Color("MonsterPurple")).padding()
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
