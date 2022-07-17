//
//  Login.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

struct LoginView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   
   @State var bgColor = Color("MonsterLime")
   @State var isSignIn = true
   @ObservedObject var loginVM = LoginViewModel()
   
   
    var body: some View {
       // Back, Title, Logo
       GeometryReader { geometry in
          ZStack {
             VStack(alignment: .leading) {
                MenuTop(showPopover: .constant(false), previousPage: .welcome)
                HStack {
                   Button(action: {
                      isSignIn = true
                      bgColor = Color("MonsterLime")
                   }, label: {
                      Text("Sign in")
                         .focus(focused: isSignIn)
                   }).padding()
                   Button(action: {
                      isSignIn = false
                      bgColor = Color("MonsterRed")
                   }, label: {
                      Text("Sign up")
                         .focus(focused: !isSignIn)
                   })
                }.padding()
                VStack {
                   Spacer()
                   if isSignIn {
                      SignInView(loginVM: loginVM, accentColor: bgColor)
                   } else {
                      SignUpView(loginVM: loginVM, accentColor: bgColor)
                   }
                   Spacer()
                }.withOverlayStyle(bgColor: .white,
                                   height: geometry.size.height * 0.82,
                                   offsetY: .zero)
             }
          }.background(bgColor)
       }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
       LoginView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AuthViewModel())
    }
}

extension Text {
   func focus(focused: Bool) -> some View {
      self.font(Font.custom("Helvetica Neue", size: focused ? 40 : 30))
         .fontWeight(.light)
         .foregroundColor(.white)
         .opacity(focused ? 1.0 : 0.5)

      }
}
