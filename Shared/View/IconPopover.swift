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
          HStack {
             if let child = authVM.childUser {
                Image(child.monster)
                Text(child.name)
             }
          }
          Button("Switch Profile") {
             navVM.currentPage = .childSelection
          }
          Button("Parent Profile") {
             print("Parent Profile")
          }
          Button("Sign Out") {
             authVM.signOut()
             // TODO: test if this is needed or automatic
             navVM.currentPage = .welcome
          }
       }.background(Color.white)
       .cornerRadius(15)
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
                     .background( Color.white.cornerRadius(15))
//                     .offset(y: 50)
               }
            },
            alignment: .bottomTrailing
         )
   }
}
