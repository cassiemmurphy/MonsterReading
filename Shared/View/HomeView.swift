//
//  HomeView.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct HomeView: View {
   @EnvironmentObject var appState: AppState
   
    var body: some View {
       VStack(alignment: .leading) {
          MenuTop()
          Text("Welcome Back")
             .foregroundColor(Color("MonsterBase"))
             .font(Font.custom("Helvetica Neue", size: 25))
             .fontWeight(.light)
             .padding(.leading)
          Text("Cassie!")
             .foregroundColor(.black)
             .font(Font.custom("Helvetica Neue", size: 45))
             .fontWeight(.semibold)
             .padding(.leading)
          Image("ProgressViewSample")
             .resizable()
             .scaledToFit()
             .frame(alignment: .center)
             .padding(.leading)
             .padding(.trailing)
          VStack {
             ActivityButton(title: "Flash Cards", image: "MonsterEyes", page: .flashCards)
             ActivityButton(title: "Mouth Pick", image: "HappyMouth")
             ActivityButton(title: "Monster Match", image: "MonsterMatch")
             ActivityButton(title: "Study Lists", image: "StudyLists")
             Spacer()
          }.padding()
       }.background(Color("MonsterPurple"))
    }
}

struct ActivityButton: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   var title: String
   var image: String
   var page: NavPage = .home
   
   var body: some View {
      Button(action: {
         if page == .home {
            print("Need to implement this page!")
         } else {
            navigationVM.currentPage = page
         }
      }, label: {
         HStack(alignment: .center) {
            Text(title)
               .font(Font.custom("Helvetica Neue", size: 24))
               .foregroundColor(.black)
               .padding()
            Spacer()
            Image(image)
               .resizable()
               .scaledToFit()
               .padding()
         }
      }).background(.white)
         .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))

   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       HomeView().environmentObject(AppState(loggedIn: true))
    }
}
