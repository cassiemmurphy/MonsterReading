//
//  MonsterPickView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct MonsterPickView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   @State var monsterSelected = false
   // FIXME: update spacing
   
    var body: some View {
       GeometryReader { geo in
          VStack {
             MenuTop(previousPage: .login)
             Spacer()
             Spacer()
             VStack {
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
                WelcomeNavigation(isEnabled: $monsterSelected, nextPage: .welcome, pageNumber: 3, accentColor: Color("MonsterPurple")).padding()
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
        MonsterPickView()
    }
}
