//
//  ChildSelectionView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/10/22.
//

import SwiftUI

struct ChildSelectionView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   
   /*
    TODO: Add background
    Get Child name & Image from DB
    Button pass to child profile
    Button pass to parent profile
    Style child buttons <-- can text be fluid to size to certain width?
    Style Parent Button
    Style or remove sign out button
    */
   
    var body: some View {
       ZStack(alignment: .center) {
          Image("BackgroundFilled")
             .resizable()
             .scaledToFill()
             .ignoresSafeArea()
          VStack(alignment: .center)  {
             ForEach(authVM.children) { child in
                Button {
                   authVM.childUser = child
                   navigationVM.currentPage = .home
                } label: {
                   VStack {
                      Image(child.monster)
                         .resizable()
                         .scaledToFit()
                         .clipShape(RoundedRectangle(cornerRadius: 25))
                         .shadow(radius: 2, x: 0, y: 1)
                      Text(child.name)
                         .font(Font.custom("Helvetica Neue", size: 30))
                         .fontWeight(.bold)
                         .foregroundColor(.white)
                   }
                }
             }
             Button {
                print("parent")
             } label: {
                Text("Parent Profile")
             }.padding()
                .background(.white)
             Button {
                authVM.signOut()
             } label: {
                Text("Sign Out")
             }

          }.padding(50)
       }
    }
}

struct ChildSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChildSelectionView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}
