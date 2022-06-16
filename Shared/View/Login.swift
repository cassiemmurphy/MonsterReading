//
//  Login.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

struct Login: View {
   @State var bgColor = Color("MonsterRed")
   @State var isSignIn = false
   
   
    var body: some View {
       // Back, Title, Logo
       GeometryReader { geometry in
          ZStack {
             VStack(alignment: .leading) {
                MenuTop()
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
                      SignIn(accentColor: bgColor)
                   } else {
                      SignUp(accentColor: bgColor)
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
        Login()
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

struct SignUp: View {
   var accentColor: Color
// FIXME: Temp form fields, to be adjusted
   @State var fullName: String = ""
   @State var email: String = ""
   @State var pin: String = ""
   @State var phone: String = ""
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      
      VStack(alignment: .leading, spacing: 20) {
         Text("Enter the following details to sign up")
            .padding(.bottom)
         TextField("Full Name", text: $fullName)
            .textFieldStyle(.roundedBorder)
         TextField("Enter your email", text: $email)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
         TextField("Enter a 6 digit login PIN", text: $pin)
            .textFieldStyle(.roundedBorder)
         TextField("Mobile", text: $phone)
            .textFieldStyle(.roundedBorder)
         Spacer()
         WelcomeNavigation(pageNumber: 2, accentColor: accentColor)
      }.padding()
   }
}

struct SignIn: View {
   var accentColor: Color
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      
      VStack {
         Text("Enter your 6 digit PIN to sign in")
         Spacer()
         WelcomeNavigation(pageNumber: 2, accentColor: accentColor)
         Spacer()
      }.padding()
   }
}

struct MenuTop: View {
   var body: some View {
      HStack {
         Button(action: {
            print("Go back to welcome page")
         }, label: {
            Image(systemName: "chevron.left")
               .resizable()
               .scaledToFit()
               .frame(height: 25)
               .foregroundColor(.white)
         })
         Spacer()
         MonsterTitle(fontSize: 30)
         Spacer()
         Image("FaceLogo")
            .resizable()
            .frame(width: 30, height: 30)
      }.padding()
   }
}
