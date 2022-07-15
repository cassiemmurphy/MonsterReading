//
//  IconPopover.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/14/22.
//

import SwiftUI

struct IconPopover: View {
   @EnvironmentObject var authVM: AuthViewModel
   @EnvironmentObject var navVM: NavigationViewModel
   
   /*
    TODO: Style and size
    Set up parent profile
    */
    var body: some View {
       VStack(alignment: .leading, spacing: 15) {
          if let child = authVM.childUser {
             HStack {
                Image(child.monster)
                   .resizable()
                   .scaledToFit()
                   .frame(height: 25)
                   .clipShape(RoundedRectangle(cornerRadius: 5))
                Text(child.name).font(Font.custom("Helvetica Neue", size: 20))
                   .foregroundColor(Color("MonsterBase"))
                   .fontWeight(.semibold)
             }
          }
          Button("Switch Profile") {
             navVM.currentPage = .childSelection
          }.foregroundColor(.black)
          Button("Parent Profile") {
             print("Parent Profile")
          }.foregroundColor(.black)
          Button("Sign Out") {
             authVM.signOut()
             // TODO: test if this is needed or automatic
             navVM.currentPage = .welcome
          }.foregroundColor(.black)
       }
    }
}

struct IconPopover_Previews: PreviewProvider {
    static var previews: some View {
       IconPopover()
          .environmentObject(AuthViewModel())
          .environmentObject(NavigationViewModel())
    }
}

extension View {
   func iconPopover<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content) -> some View {
      self
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .overlay (
            ZStack {
               if show.wrappedValue {
                  content()
                     .padding()
                     .background( Color.white.cornerRadius(10))
                     .shadow(color: Color.primary.opacity(0.05), radius: 5, x: 5, y: 5)
                     .offset(x: -20, y: 65)
               }
            },
            alignment: .topTrailing
         )
   }
}
