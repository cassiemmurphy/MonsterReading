//
//  HomeView.swift
//
//  Created by Murphy, Cassie on 5/12/22.
//

import SwiftUI

struct HomeView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   
   @State var showPopover = false
   
   /*
    TODO: add popover on icon upper right: Switch Profile, Parent Profile, Sign Out
    Make parent page
    Make Child Page
    Adjust points and graphs
    Remove Sign Out Button
    */
   
    var body: some View {
       VStack(alignment: .leading) {
          MenuTop(showPopover: $showPopover)
          Text("Welcome Back")
             .foregroundColor(Color("MonsterBase"))
             .font(Font.custom("Helvetica Neue", size: 25))
             .fontWeight(.light)
             .padding(.leading)
          Text(authVM.childUser?.name.capitalized ?? "")
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
             ActivityButton(title: "Mouth Pick", image: "HappyMouth", page: .home)
             ActivityButton(title: "Monster Match", image: "MonsterMatch", page: .home)
             ActivityButton(title: "Study Lists", image: "StudyLists", page: .studyLists)
             Spacer()
          }.padding()
       }.background(Color("MonsterPurple"))
       .iconPopover(show: $showPopover) {
          IconPopover()
       }
    }
}

struct ActivityButton: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   
   var title: String
   var image: String
   var page: NavPage
   
   var body: some View {
      Button(action: {
         navigationVM.currentPage = page
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
       HomeView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}
