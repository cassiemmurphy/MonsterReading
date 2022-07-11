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
                } label: {
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
             
             ForEach(1...3, id: \.self) { index in
                Button {
                   print("child")
                } label: {
                   VStack {
                      Image("Monster\(index)")
                         .resizable()
                         .scaledToFit()
                         .clipShape(RoundedRectangle(cornerRadius: 25))
                         .shadow(radius: 2, x: 0, y: 1)
                      Text("Child Name")
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
          }.padding(50)
       }.onAppear {
          authVM.getChildren()
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
